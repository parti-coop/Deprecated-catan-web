class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :position, null: false, index: true
      t.references :user, null: false, index: true
      t.references :trackable, polymorphic: true, null: false, index: true
      t.string :key, null: false
      t.timestamps null: false
    end

    add_index :activities, :created_at
  end
end
