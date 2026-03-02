class RemoveDeviseTokenAuthFieldsFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_index :users, name: "index_users_on_uid_and_provider"

    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
    remove_column :users, :tokens, :text
  end
end
