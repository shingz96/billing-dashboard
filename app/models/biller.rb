class Biller < ApplicationRecord
  validates :code, :name, :url, presence: true
  validates_uniqueness_of :code, case_sensitive: false

  before_validation :normalize_data

  private

  def normalize_data
    self.code = code.strip.downcase if code.present?
    self.name = name.strip if name.present?
    self.url = url.strip.downcase if url.present?
  end
end
