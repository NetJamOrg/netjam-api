class UserOauthStuff < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :password_hash, :string
    add_column :users, :oauth_uid, :string
    add_column :users, :provider, :string
  end
end
