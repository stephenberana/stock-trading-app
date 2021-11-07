class AddStockIdToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :stock_id, :integer
  end
end
