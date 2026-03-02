class AddTotalPriceToExpenses < ActiveRecord::Migration[8.0]
  def change
    add_column :expenses, :total_price, :decimal, precision: 10, scale: 2
  end
end
