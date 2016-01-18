class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can :create, Position
      can :manage, Position do |position|
        position.user == user
      end

      can :create, Opinion
      can :manage, Opinion do |opinion|
        opinion.user == user
      end

      can :create, Vote

      can :create, Support
      can :cancel, Support do |support|
        support.supporter == user
      end
    end
  end
end
