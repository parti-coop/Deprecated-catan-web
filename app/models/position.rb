class Position < ActiveRecord::Base
  belongs_to :user
  has_many :opinions
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
