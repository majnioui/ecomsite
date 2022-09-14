class CreateOrderitems < ActiveRecord::Migration[6.0]
def change
  create_table :orderitems do |t|
    t.integer :quantity
    t.references :product, null: false, foreign_key: true
    t.references :order, null: false, foreign_key: true

    t.decimal :total
    t.decimal :unit_price
    
    t.timestamps
  end
end
