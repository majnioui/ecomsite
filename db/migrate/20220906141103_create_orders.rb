class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :total
      t.string :status
      t.date :orderdate

      t.timestamps
    end
  end
end
