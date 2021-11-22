class AddCommpanyNameToTrades < ActiveRecord::Migration[6.1]
  def change
    add_column :trades, :company_name, :string
  end
end
