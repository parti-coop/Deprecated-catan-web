class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :user, null: false, index: true
      t.text :body
      t.timestamps null: false
    end
  end
end
