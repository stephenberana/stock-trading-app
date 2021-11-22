class AddTickerToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :ticker, :string
  end
end
