class Position < ActiveRecord::Base
  belongs_to :user
  has_many :opinions
  has_many :votes

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
