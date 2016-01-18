class CreateSupports < ActiveRecord::Migration
  def change
    create_table :supports do |t|
      t.references :leader, null: false
      t.references :supporter, null: false, index: true
      t.timestamps null: false
    end

    add_index :supports, [:leader_id, :supporter_id], unique: true
  end
end
