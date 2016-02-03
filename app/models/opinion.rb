class Opinion < ActiveRecord::Base
  include Chociable

  belongs_to :user
  belongs_to :position
  has_many :likes, dependent: :destroy, counter_cache: true
  belongs_to :source, class_name: Opinion, foreign_key: :source_id
  has_many :response, class_name: Opinion, source: :source, foreign_key: :source_id
  has_many :activities, as: :trackable

  def liked_by? user
    likes.exists?(user: user)
  end

  def best?
    position.opinions.best? self
  end
end
