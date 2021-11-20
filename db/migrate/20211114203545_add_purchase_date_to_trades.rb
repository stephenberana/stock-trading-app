class AddPurchaseDateToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :purchase_date, :date
  end
end
