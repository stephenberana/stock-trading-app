class CreateBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :balances do |t|
      t.integer :deposit
      t.integer :withdrawals

      t.timestamps
    end
  end
end
