class CreateOpinions < ActiveRecord::Migration
  def change
    create_table :opinions do |t|
      t.references :user, null: false, index: true
      t.references :position, null: false, index: true
      t.text :body
      t.timestamps null: false
    end
  end
end
