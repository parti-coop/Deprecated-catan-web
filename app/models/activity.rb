class Activity < ActiveRecord::Base
  extend Enumerize

  belongs_to :position, dependent: :destroy
  belongs_to :user, dependent: :destroy
  belongs_to :trackable, polymorphic: true, dependent: :destroy
  belongs_to :vote, -> { joins(:activities).where(activities: {trackable_type: Vote}) }, foreign_key: :trackable_id
  belongs_to :opinion, -> { joins(:activities).where(activities: {trackable_type: Opinion}) }, foreign_key: :trackable_id
  enumerize :key, in: %w(create_position create_opinion vote), predicates: true, scope: true

  scope :concerned_by, -> (user) { past_week.where(user: user.leaders ) }
  scope :of_agree, -> { joins(:vote).where(votes: { choice: 'agree' }) }
  scope :of_disagree, -> { joins(:vote).where(votes: { choice: 'disagree' }) }
  scope :of_opinion, -> { joins(:opinion) }
  def self.by someone
    where(user: someone)
  end
end
