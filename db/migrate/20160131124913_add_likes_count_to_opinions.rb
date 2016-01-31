class AddLikesCountToOpinions < ActiveRecord::Migration

  def self.up
    add_column :opinions, :likes_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :opinions, :likes_count
  end

end
