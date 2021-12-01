class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :redirect_index, only: [:new, :create]

  def index
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.valid?
      @event.save
      redirect_to root_path
    else
      render :new
      flash.now[:alert] = 'Fail in'
    end
  end

  private
  def event_params
    params.require(:event).permit(:event_title, :place, :prefecture_id, :genre_id, :date, :image).merge(user_id: current_user.id)
  end
  
  def redirect_index
    redirect_to root_path if current_user.admin = 0
  end
end
