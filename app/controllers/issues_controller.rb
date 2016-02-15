class IssuesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource
  respond_to :json, :html

  def show

  end

  def index
    @issues = Issue.where("title like ?", "%#{params[:query]}%" ).limit(10)
    respond_with @issues
  end

  def create
    @issue.user = current_user
    if @issue.save
      redirect_to @issue
    else
      render 'new'
    end
  end

  def update
    if @issue.update(update_params)
      redirect_to @issue
    else
      render 'edit'
    end
  end

  private

  def create_params
    params.require(:issue).permit(:title, :description)
  end

  def update_params
    params.require(:issue).permit(:title, :description)
  end
end
