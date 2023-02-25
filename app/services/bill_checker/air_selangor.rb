module BillChecker
  class AirSelangor < BillChecker::Base
    URL = 'https://crismobile2.airselangor.com'.freeze

    def mechanize_agent
      @mechanize_agent ||= Mechanize.new
    end

    def faraday_client
      headers = {
        'Accept' => 'application/vnd.airselangor.portal.api+json;channel=apiv2',
        'CLIENT-SERVICE' => 'Syabas-Portal-Service',
        'X-POWERED-BY' => 'Syabas-Air-Selangor'
      }

      @faraday_client ||= Faraday.new(url: URL, headers: headers) do |f|
        f.request :json
        f.response :json
      end
    end

    def generate_pdf
      login

      info = faraday_client.get("api/portal/cris/#{account_id}/history_bill") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end
      info = info.body.dig('data') || {}

      bill_ids = info.dig('bill').pluck('bill_id', 'year')
      bill_ids.each do |bill_id, year|
        pdf = faraday_client.get("api/portal/cris/bill/personal/#{bill_id}?year=#{year}") do |req|
          req.headers["Authorization"] = "Bearer #{token}"
        end

        return pdf.body.dig('data', 'file') if pdf.success?
      end
    end

    def pdf_url
      generate_pdf
    end

    def payment_url
      @bill.biller.url
    end

    def extract_bill_info
      info = faraday_client.get("api/portal/cris/#{account_id}/current_bill") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end

      info = info.body.dig('data') || {}

      self.class.define_method(:address) do
        info.dig('account', 'account', 'address')
      end

      self.class.define_method(:bill_date) do
        info['bill_date'].to_date rescue nil
      end

      self.class.define_method(:due_amount) do
        info['total_amount']
      end

      self.class.define_method(:due_date) do
        info['bill_due_date'].to_date rescue nil
      end

      self.class.define_method(:owner_name) do
        info.dig('account', 'account', 'account_real_name')
      end
    end

    private

    def token
      @token ||= begin
        body = {
          "device_name" => "Chrome",
          "os_version" => "109",
          "device_id" => SecureRandom.uuid
        }
        response = faraday_client.post('api/portal/token', body)
        response.body.dig('data', 'token')
      end
    end

    def login
      body = {
        "email" => ENV.fetch('AIR_SELANGOR_USERNAME', nil),
        "password" => ENV.fetch('AIR_SELANGOR_PASSWORD', nil)
      }
      response = faraday_client.post('api/portal/auth/login', body) do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end

      response.success?
    end

    def account_id
      @account_id ||= begin
        login
        get_account_id_from_db if get_account_id_from_db.present?
        get_account_id_from_api
      end
    end

    def get_account_id_from_db
      @bill.metadata['account_id']
    end

    def get_account_id_from_api
      response = faraday_client.get('api/portal/cris/account_list') do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end
      if response.success?
        accounts = response.body.dig('data')
        accounts.each do |account|
          next unless account.dig('account', 'account_id') == @bill.account_no

          @bill.metadata['account_id'] = account.dig('id')
          @bill.save

          return account.dig('id')
        end
      end
    end
  end
end
