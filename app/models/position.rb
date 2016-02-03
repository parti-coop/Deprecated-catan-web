class Position < ActiveRecord::Base
  belongs_to :user
  has_many :opinions do
    %w(agree disagree).each do |choice|
      define_method "#{choice}_maximum_likes_count" do
        where(choice: choice).maximum(:likes_count)
      end

      define_method "#{choice}_minimum_likes_count" do
        where(choice: choice).minimum(:likes_count)
      end

      define_method "#{choice}_best" do
        where(choice: choice)
        .where(likes_count: send(:"#{choice}_maximum_likes_count"))
        .where.not(likes_count: send(:"#{choice}_minimum_likes_count"))
      end
    end

    def best
      unscoped.where.any_of(agree_best, disagree_best).order(likes_count: :desc).order(created_at: :desc)
    end

    def not_best
      none_of(agree_best, disagree_best).order(created_at: :desc)
    end

    def best? opinion
      maximum_likes_count = try(:"#{opinion.choice}_maximum_likes_count")
      minimum_likes_count = try(:"#{opinion.choice}_minimum_likes_count")
      return false if maximum_likes_count == minimum_likes_count
      return opinion.likes_count >= maximum_likes_count
    end
  end
  has_many :votes do
    def by_leaders_of(user)
      where(user: user.leaders)
    end

    def by_leaders_me(user)
      where(user: [user.leaders, user].flatten)
    end

    %w(agree disagree).each do |choice|
      define_method "#{choice}_percent" do
        choice_count = where(choice: choice).count.to_f
        total_count = where(choice: %w(agree disagree)).count.to_f
        (100 *  choice_count / total_count).round
      end
    end
  end

  has_many :activities

  scope :touched_by_leaders_of, -> (user) { includes(:activities).references(:activities).where(activities: { user: user.leaders }).order('activities.created_at desc') }
  def voted_by voter
    votes.where(user: voter).first
  end

  def voted? voter
    votes.exists? user: voter
  end

  def agreed? voter
    votes.exists? user: voter, choice: 'agree'
  end

  def disagreed? voter
    votes.exists? user: voter, choice: 'disagree'
  end
end
