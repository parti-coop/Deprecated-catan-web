# This migration comes from parti_sso_client (originally 20151216185942)
class UniqueIndexEmailOfUsers < ActiveRecord::Migration
  def change
    remove_index :users, :email
    add_index :users, :email, unique: true
  end
end
