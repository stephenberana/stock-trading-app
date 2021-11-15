class RemoveColumnFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :superadmin_role
    remove_column :users, :trader_role
  end
end
