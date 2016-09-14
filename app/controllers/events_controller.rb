class EventsController < ApplicationController
  def index
    if current_user
      @events = Event.stream_for_user(current_user).limit(100)
    else
      @events = Event.limit(100)
    end
  end
end
