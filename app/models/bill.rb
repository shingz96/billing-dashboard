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
      end
  end

  def bill_info
    return unless bill_checker.present?

    bill_checker.bill_info
  end
end
