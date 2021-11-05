class ChangeDefaultForApproved < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :approved, :boolean, :default => false
  end
end
