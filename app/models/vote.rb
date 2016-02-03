class Vote < ActiveRecord::Base
  include Chociable

  belongs_to :user
  belongs_to :position
  has_many :activities, as: :trackable
end

