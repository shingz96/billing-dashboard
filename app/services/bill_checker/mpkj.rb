module BillChecker
  class Mpkj < BillChecker::Base
    URL = 'https://ebayar.mpkj.gov.my'.freeze

    def mechanize_agent
      @mechanize_agent ||= Mechanize.new
    end

    def faraday_client
      @faraday_client ||= Faraday.new do |f|
        f.response :json
      end
    end

    def generate_pdf
      # login
      page = mechanize_agent.get('https://ebayar.mpkj.gov.my/sso/Default.aspx')
      form = page.form('aspnetForm')
      form.send("ctl00$mainContentPlaceHolder$Login1$UserName=", ENV.fetch('MPKJ_USERNAME', nil))
      form.send("ctl00$mainContentPlaceHolder$Login1$Password=", ENV.fetch('MPKJ_PASSWORD', nil))
      btn = form.buttons_with(name: 'ctl00$mainContentPlaceHolder$Login1$LoginButton').first
      page = mechanize_agent.submit(form, btn)

      # page = mechanize_agent.get('https://ebayar.mpkj.gov.my/sso/serverpages/Members/Services.aspx')
      # page = mechanize_agent.get('https://ebayar.mpkj.gov.my/sso/serverpages/Members/TaxBil.aspx?accno=31B0004A046-0364963')

      pdf = mechanize_agent.get("https://ebayar.mpkj.gov.my/sso/serverpages/Members/TaxBilPdf.aspx?accno=#{@bill.account_no}")
      # pdf.save
    end

    def payment_url
      "https://ebayar.mpkj.gov.my/ebayar/public/tax?accountno=#{@bill.account_no}"
    end

    def extract_bill_info
      info = faraday_client.get("https://ebayar.mpkj.gov.my/webapi/api/services/gettaxbyaccountno?accountno=#{@bill.account_no}")
      info = info.body

      self.class.define_method(:address) do
        %w[PropertyAddress1 PropertyAddress2 PropertyAddress3 Postcode].map do |field|
          info[field]
        end.join(', ')
      end

      self.class.define_method(:bill_date) do
        info['BillDate'].to_date rescue nil
      end

      self.class.define_method(:due_amount) do
        info['Total']
      end

      self.class.define_method(:due_date) do
        if bill_date.present?
          (bill_date + 1.month).end_of_month
        end
      end

      self.class.define_method(:owner_name) do
        info['OwnerName']
      end
    end
  end
end
