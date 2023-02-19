module BillChecker
  class Base
    def initialize(bill, *args, **kwargs)
      @bill = bill
      define_bill_info_methods
    end

    def extract_bill_info
      raise NotImplementedError
    end

    def payment_url
      raise NotImplementedError
    end

    def generate_pdf
      raise NotImplementedError
    end

    def pdf_url
      Rails.application.routes.url_helpers.pdf_bill_url(@bill)
    end

    def bill_info_fields
      %i[
        address
        bill_date
        due_amount
        due_date
        owner_name
      ]
    end

    def bill_info
      return @result if @result.present?

      extract_bill_info
      @result = {}
      bill_info_fields.each do |field|
        @result[field] = send(field)
      end

      @result
    end

    def define_bill_info_methods
      bill_info_fields.each do |attribute|
        self.class.define_method(attribute) do
          raise NotImplementedError
        end
      end
    end
  end
end
