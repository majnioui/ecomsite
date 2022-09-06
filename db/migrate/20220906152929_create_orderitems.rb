class CreateOrderitems < ActiveRecord::Migration[6.0]
  def change
    create_table :orderitems do |t|
      t.integer :quantity
      t.integer :unit
      t.integer :total
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
