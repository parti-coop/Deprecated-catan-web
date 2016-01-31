class AddSourceToOpinions < ActiveRecord::Migration
  def change
    add_reference :opinions, :source, null: true, index: true
  end
end
