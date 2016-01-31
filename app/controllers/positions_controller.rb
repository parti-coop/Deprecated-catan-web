class PositionsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  load_and_authorize_resource

  def index
    @positions = Position.all.order(created_at: :desc)
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
    @position.user = current_user
    if @position.save
      redirect_to @position
    else
      render 'new'
    end
  end

  def update
    if @position.update_attributes(position_params)
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
end
