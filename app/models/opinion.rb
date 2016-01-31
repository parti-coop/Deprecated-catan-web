class Opinion < ActiveRecord::Base
  include Chociable

  belongs_to :user
  belongs_to :position
  has_many :likes, dependent: :destroy, counter_cache: true

  def liked_by? user
    likes.exists?(user: user)
  end

  def best?
    position.opinions.best? self
  end
end
