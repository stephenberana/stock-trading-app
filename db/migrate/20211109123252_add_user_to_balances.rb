class AddUserToBalances < ActiveRecord::Migration[6.1]
  def change
    add_reference :balances, :user, null: false, foreign_key: true
  end
end
