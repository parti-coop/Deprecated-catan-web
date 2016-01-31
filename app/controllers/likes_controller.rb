class LikesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource :opinion

  def create
    unless @opinion.liked_by?(current_user)
      @opinion.likes.build(user: current_user)
      @opinion.save
    end

    redirect_to @opinion.position
  end

  def destroy_by_me
    @like = @opinion.likes.find_by user: current_user
    @like.destroy if @like.present?
    redirect_to @opinion.position
  end

  private

  def opinion_params
    params.require(:opinion).permit(:body)
  end
end
