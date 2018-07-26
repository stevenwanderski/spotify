class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :auth_hash, :jsonb
    add_index :users, :provider
    add_index :users, :uid
  end
end
