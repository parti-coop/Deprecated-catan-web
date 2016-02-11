class IssuesController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

  def show

  end

  def index

  end

  def create
    @issue.user = current_user
    if @issue.save
      redirect_to @issue
    else
      render 'new'
    end
  end

  private

  def create_params
    params.require(:issue).permit(:title, :description)
  end
end
