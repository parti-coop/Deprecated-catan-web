class VotesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  authorize_resource :vote

  def create
    @position = Position.find params[:position_id]

    previous_vote = @position.voted_by current_user
    if previous_vote.present?
      @vote = previous_vote
      @vote.choice = params[:vote][:choice]
    else
      @vote = @position.votes.build vote_params
      @vote.user = current_user
    end
    if @vote.save
      @activity = Activity.find_or_create_by(position: @position, trackable: @vote, user: current_user, key: 'vote')
      @activity.touch(:created_at)
    end

    redirect_to @vote.position
  end

  private

  def vote_params
    params.require(:vote).permit(:choice)
  end
end
