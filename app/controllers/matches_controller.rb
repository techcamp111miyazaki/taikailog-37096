class MatchesController < ApplicationController
  before_action :set_event, only: [:index]

  def index
    @matches = @event.matches
  end

  private###

  def set_event
    @event = Event.find(params[:event_id])
  end

end
