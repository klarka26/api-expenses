class ChangeDecimalsInExpenses < ActiveRecord::Migration[8.0]
  def change
    change_column :expenses, :tax_base, :decimal, precision: 10, scale: 2
    change_column :expenses, :vat_rate, :decimal, precision: 5, scale: 2
    change_column :expenses, :vat_amount, :decimal, precision: 10, scale: 2
  end
end
