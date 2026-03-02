class CreateExpenseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :expense_items do |t|
      t.references :expense, null: false, foreign_key: true
      t.string :description
      t.decimal :quantity, precision: 10, scale: 2
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
