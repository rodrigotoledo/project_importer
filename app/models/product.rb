class Product < ApplicationRecord
  belongs_to :import
  validates :date, :product_id, :weight, presence: true
end
