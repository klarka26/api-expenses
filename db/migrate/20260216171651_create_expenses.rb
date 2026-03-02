class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.datetime :document_date
      t.decimal :tax_base
      t.decimal :vat_rate
      t.decimal :vat_amount
      t.string :uid
      t.string :kp
      t.string :okp
      t.string :receipt_number

      t.timestamps
    end
  end
end
