class Support < ActiveRecord::Base
  belongs_to :leader, class_name: User, foreign_key: :leader_id
  belongs_to :supporter, class_name: User, foreign_key: :supporter_id
end
