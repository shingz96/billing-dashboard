class Biller < ApplicationRecord
  validates :code, :name, :url, presence: true
  validates_uniqueness_of :code

  def code=(value)
    value = value.downcase if value.present?
    super(value)
  end
end
