require 'csv'
require 'activerecord-import/base'
class Import < ApplicationRecord
  has_one_attached :file
  has_many :products

  def create_products_from_file
    return unless file.attached?
    
    unit_to_conversion = {
      'kilograms' => 1,
      'pounds' => 0.45359237,
      'grams' => 0.001
    }
    csv_file = file.download
    products_data = []
    CSV.parse(csv_file, headers: true) do |row|
      product_id = row[1]
      category = product_id[0..2]
      weight = row[2]
      unit = row[3]
      weight_kg = weight * unit_to_conversion[unit] if unit_to_conversion[unit]

      product_data = products.build(
        date: row[0],
        product_id: product_id,
        weight: weight_kg,
        category: category
      )
      
      products_data << product_data
    end

    Product.import(products_data, validate: false) if products_data.any?
  end
end
