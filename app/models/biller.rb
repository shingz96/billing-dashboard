# == Schema Information
#
# Table name: billers
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_billers_on_code  (code) UNIQUE
#
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
