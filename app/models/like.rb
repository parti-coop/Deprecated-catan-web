class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :opinion

  validate :not_by_owner

  default_scope { order("created_at DESC") }

  private

  def not_by_owner
    if opinion.user == user
      errors.add(:user, "should not be owner of opinion")
    end
  end
end
