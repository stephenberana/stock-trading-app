class ChangeIntegerToDecimal < ActiveRecord::Migration[6.1]
  def up
    change_column :balances, :deposit, :decimal, precision: 10, scale: 2
    change_column :balances, :withdrawals, :decimal, precision: 10, scale: 2
    change_column :trades, :price, :decimal, precision: 10, scale: 2
  end

  def down
    change_column :balances, :deposit, :integer
    change_column :balances, :withdrawals, :integer
    change_column :trades, :price, :float
  end
end
