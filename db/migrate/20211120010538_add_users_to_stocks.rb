class AddUsersToStocks < ActiveRecord::Migration[6.1]
  def change
    add_reference :stocks, :user, null: true, foreign_key: true
  end
end
