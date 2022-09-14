class AddUnitPriceToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :unit_price, :decimal
  end
end
