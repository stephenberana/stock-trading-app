class AddTradesToStocks < ActiveRecord::Migration[6.1]
  def change
    add_reference :stocks, :trade, null: true, foreign_key: true
  end
end
