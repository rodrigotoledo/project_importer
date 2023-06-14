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
      weight = row[2]
      unit = row[3]
      case unit
      when 'kilograms'
        weight_kg = weight
      when 'pounds'
        weight_kg = weight * 0.45359237
      when 'grams'
        weight_kg = weight * 0.001
      else
        next  # Ignorar unidades desconhecidas
      end

      
      product = products.build(
        date: row[0],
        product_id: product_id,
        weight: weight_kg,
        category: category
      )
      
      product.save!
    end
  end
end
