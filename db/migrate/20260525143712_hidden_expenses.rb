class HiddenExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :hidden_expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
      t.timestamps
    end

    add_index :hidden_expenses, [ :user_id, :expense_id ], unique: true
  end
end
