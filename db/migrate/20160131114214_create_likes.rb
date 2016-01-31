class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, null: false, index: true
      t.references :opinion, null: false, index: true
      t.timestamps null: false
    end

    add_index :likes, [:user_id, :opinion_id], unique: true
  end
end
