class AddTotalToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_column :orderitems, :total, :decimal
  end
end
