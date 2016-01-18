class SupportsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @support.supporter = current_user
    @support.save unless @support.supporter == @support.leader
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def cancel
    @leader = User.find params[:leader_id]
    @support = @leader.support_by current_user
    @support.destroy if @support.present?
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def create_params
    params.require(:support).permit(:leader_id)
  end
end
