class CreateSuppliers < ActiveRecord::Migration[8.0]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :ico
      t.string :dic
      t.string :ic_dph
      t.string :address

      t.timestamps
    end
  end
end
