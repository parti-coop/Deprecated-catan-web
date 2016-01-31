class Opinion < ActiveRecord::Base
  include Chociable

  belongs_to :user
  belongs_to :position
  has_many :likes, dependent: :destroy

  default_scope { order("created_at DESC") }

  def liked_by? user
    likes.exists?(user: user)
  end
end
