class Bill < ApplicationRecord
  belongs_to :biller
  belongs_to :entity

  enum cadence: %i[monthly half_yearly yearly]

  def name
    nickname.present? ? nickname : entity.name
  end

  def bill_checker
    @bill_checker ||=
      case biller.code.downcase
      when 'mpkj'
        BillChecker::Mpkj.new(self)
      when 'air_selangor'
        BillChecker::AirSelangor.new(self)
      end
  end

  def bill_info
    return unless bill_checker.present?

    {
      payment_url: bill_checker.payment_url,
      pdf_url: bill_checker.pdf_url
    }.merge(bill_checker.bill_info)
  end
end
