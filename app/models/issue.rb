class Issue < ActiveRecord::Base
  # relations
  belongs_to :user
  has_many :positions
end
