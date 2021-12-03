class MatchesController < ApplicationController
  before_action :set_event
  before_action :set_match, only: [:show, :edit, :update, :destroy]
  before_action :redirect_index, except: [:index, :show]

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

  def show
  end

  def edit
    @match = Match.new(turn_id: @match.turn_id, field_id: @match.field_id, order_number: @match.order_number, player_name_1: @match.player_name_1, belongs_1: @match.belongs_1, score_1: @match.score_1, player_name_2: @match.player_name_2, belongs_2: @match.belongs_2, score_2: @match.score_2, log: @match.log)
  end

  def update
    if @match.update(match_params)
      @match.save
      redirect_to event_matches_path(@event.id)
    else
      render :edit
      flash.now[:alert] = 'Fail in'
    end
  end

  def destroy
    @match.destroy
    redirect_to event_matches_path(@event.id)
  end

  private###

  def set_event
    @event = Event.find(params[:event_id])
  end

  def match_params
    params.require(:match).permit(:turn_id, :field_id, :order_number, :player_name_1, :belongs_1, :score_1, :player_name_2, :belongs_2, :score_2, :log).merge(user_id: current_user.id, event_id: params[:event_id])
  end

  def set_match
    @match = Match.find(params[:id])
  end

  def redirect_index
    redirect_to event_matches_path(@event.id) if @event.user.id != current_user.id
  end

end
