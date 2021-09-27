class RemoveShopingCostFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :shoping_cost, :integer
  end
end
