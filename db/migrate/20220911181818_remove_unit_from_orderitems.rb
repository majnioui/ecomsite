class RemoveUnitFromOrderitems < ActiveRecord::Migration[6.0]
  def change
    remove_column :orderitems, :unit, :integer
  end
end
