class OpinionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource :position
  load_and_authorize_resource :opinion, through: :position, shallow: true

  def new
  end

  def create
    @opinion.user = current_user

    @vote = @opinion.position.voted_by current_user
    @opinion.choice = @vote.try(:choice)

    if @opinion.save
      Activity.create(position: @opinion.position, trackable: @opinion, user: current_user, key: 'create_opinion')
      redirect_to @opinion.position
    else
      render 'new'
    end
  end

  def update
    @opinion.update_attributes(opinion_params)
    redirect_to @opinion.position
  end

  def destroy
    @opinion.destroy
    redirect_to @opinion.position
  end

  private

  def opinion_params
    params.require(:opinion).permit(:body, :source_id)
  end
end
