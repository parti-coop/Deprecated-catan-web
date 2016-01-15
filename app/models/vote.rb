class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :position

  scope :agree, -> { where(choice: 'agree') }
  scope :disagree, -> { where(choice: 'disagree') }
end

