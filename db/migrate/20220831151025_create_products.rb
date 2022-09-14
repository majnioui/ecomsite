class CreateProducts < ActiveRecord::Migration[6.0]
def change
  create_table :products do |t|
    t.string :name
    t.integer :stock
    t.text :description
    t.references :buyer, null: false, foreign_key: { to_table: :users}
    t.float :price, default: 0
    t.timestamps
  end
end