class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :redirect_index, only: [:new, :create]
  before_action :set_event, only: [:edit, :update, :destroy]

  def index
    @events = Event.order('created_at DESC')
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

  def edit
  end

  def update
    if @event.update(event_params)
      @event.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path
  end

  private
  def event_params
    params.require(:event).permit(:event_title, :place, :prefecture_id, :genre_id, :date, :image).merge(user_id: current_user.id)
  end
  
  def redirect_index
    redirect_to root_path if current_user.admin == false
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def redirect_not_admin
    event = Event.find(params[:id])
    redirect_to root_path unless current_user.id == event.user.id
  end
end
