# == Schema Information
#
# Table name: bills
#
#  id         :bigint           not null, primary key
#  account_no :string
#  cadence    :integer
#  metadata   :jsonb
#  nickname   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  biller_id  :bigint           not null
#  entity_id  :bigint           not null
#
# Indexes
#
#  index_bills_on_biller_id  (biller_id)
#  index_bills_on_entity_id  (entity_id)
#
# Foreign Keys
#
#  fk_rails_...  (biller_id => billers.id)
#  fk_rails_...  (entity_id => entities.id)
#
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
