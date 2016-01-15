class AddChoiceToOpinions < ActiveRecord::Migration
  def change
    add_column :opinions, :choice, :string
  end
end
