require 'csv'
class Import < ApplicationRecord
  has_one_attached :file
  has_many :products

  def create_products_from_file
    return unless file.attached?
    
    csv_file = file.download
    CSV.parse(csv_file, headers: true) do |row|
      product_id = row[1]
      category = product_id[0..2]
      
      product = products.build(
        date: row[0],
        product_id: product_id,
        weight: row[2],
        unit: row[3],
        category: category
      )
      
      product.save!
    end
  end
end
