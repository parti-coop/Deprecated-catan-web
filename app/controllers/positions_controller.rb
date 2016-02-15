class PositionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

  def index
    if user_signed_in? and current_user.leaders.any?
      @positions_touched_by_leaders = Position.touched_by_leaders_of(current_user)
    end

    @positions = Position.order(created_at: :desc)
  end

  def show
    render stauts: 404 and return if @position.nil?
    render 'show'
  end

  def new
  end

  def edit
  end

  def create
    set_issue
    @position.user = current_user

    if @position.save
      Activity.create(position: @position, trackable: @position, user: current_user, key: 'create_position')
      redirect_to @position
    else
      render 'new'
    end
  end

  def update
    @position.assign_attributes(position_params)
    set_issue
    if @position.save
      redirect_to @position
    else
      render 'edit'
    end
  end

  def destroy
    @position.destroy
    redirect_to positions_path
  end

  private

  def position_params
    params.require(:position).permit(:body)
  end

  def set_issue
    @position.issue = Issue.find_or_create_by({title: params[:issue_title]}) do |issue|
      issue.user = current_user
    end
  end

end
