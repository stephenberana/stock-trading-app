class CreateTrades < ActiveRecord::Migration[6.1]
  def change
    create_table :trades do |t|
      t.integer :quantity
      t.float :price
      t.timestamps
    end
  end
end
