class AddProductRefToOrderitems < ActiveRecord::Migration[6.0]
  def change
    add_reference :orderitems, :product, null: false, foreign_key: true
  end
end
