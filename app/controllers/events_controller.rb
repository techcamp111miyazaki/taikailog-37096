class EventsController < ApplicationController

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
      flash.now[:alert] = '新規投稿に失敗しました'
    end
  end

  private
  def event_params
    params.require(:event).permit(:event_title, :place, :prefecture_id, :genre_id, :date, :image).merge(user_id: current_user.id)
  end
end
