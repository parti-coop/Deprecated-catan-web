Rails.application.config.to_prepare do
  User.class_eval do
    def leader_of? someone
      Support.exists?(supporter: someone, leader: self)
    end

    def support_by someone
      Support.where(supporter: someone, leader: self).first
    end
  end
end
