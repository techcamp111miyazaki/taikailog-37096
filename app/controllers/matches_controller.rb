class MatchesController < ApplicationController
  before_action :set_event, only: [:index, :new, :create]

  def index
    @matches = @event.matches
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    if @match.valid?
      @match.save
      redirect_to event_matches_path(@event.id)
    else
      render :new
      flash.now[:alert] = 'Fail in'
    end
  end

  private###

  def set_event
    @event = Event.find(params[:event_id])
  end

  def match_params
    params.require(:match).permit(:turn_id, :field_id, :order_number, :player_name_1, :belongs_1, :score_1, :player_name_2, :belongs_2, :score_2, :log).merge(user_id: current_user.id, event_id: params[:event_id])
  end

end
