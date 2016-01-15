class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user, null: false, index: true
      t.references :position, null: false
      t.string :choice, null: false
      t.timestamps null: false
    end

    add_index :votes, [:position_id, :user_id], unique: true
  end
end
