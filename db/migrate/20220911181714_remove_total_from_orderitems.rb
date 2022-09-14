class RemoveTotalFromOrderitems < ActiveRecord::Migration[6.0]
  def change
    remove_column :orderitems, :total, :integer
  end
end
