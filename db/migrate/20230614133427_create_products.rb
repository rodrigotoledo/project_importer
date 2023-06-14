class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :import, null: false, foreign_key: true
      t.string :date
      t.string :category
      t.string :product_id
      t.string :weight
      t.string :unit

      t.timestamps
    end
  end
end
