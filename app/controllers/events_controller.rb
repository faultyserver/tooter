class EventsController < ApplicationController
  def index
    if current_user
      @events = Event.stream_for_user(current_user)
    else
      @events = Event.all
    end
  end
end
