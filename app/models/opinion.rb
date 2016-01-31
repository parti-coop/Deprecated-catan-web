class Opinion < ActiveRecord::Base
  include Chociable

  belongs_to :user
  belongs_to :position

  default_scope { order("created_at DESC") }
end
