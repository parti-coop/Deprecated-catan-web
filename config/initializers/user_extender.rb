Rails.application.config.to_prepare do
  User.class_eval do
    has_many :active_supports,
      class_name:  Support,
      foreign_key: :supporter_id,
      dependent:   :destroy
    has_many :passive_supports,
      class_name:  Support,
      foreign_key: :leader_id,
      dependent:   :destroy
    has_many :leaders, through: :active_supports, source: :leader
    has_many :supporters, through: :passive_supports, source: :supporter

    def leader_of? someone
      Support.exists?(supporter: someone, leader: self)
    end

    def support_by someone
      Support.where(supporter: someone, leader: self).first
    end
  end
end
