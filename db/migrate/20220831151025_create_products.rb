class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :stock
      t.integer :price

      t.timestamps
    end
  end
end
