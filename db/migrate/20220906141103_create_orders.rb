class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :subtotal # Before discount
      t.decimal :total  # For any discount you may want to add
      t.references :user, index: true, null: false, foreign_key: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
