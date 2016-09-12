class FavoritesController < ApplicationController
  # POST /toots/:id/favorite
  def create
    @event = Event.new(favorite_params)

    if @event.save
      redirect_to @event.subject
    else
      redirect_to @event.subject, notice: "Could not favorite the #{@event.subject.class}"
    end
  end

  # POST /toots/:id/unfavorite
  def destroy
    @event = Event.find_by(favorite_params)

    if @event.destroy
      redirect_to @event.subject
    else
      redirect_to @event.subject, notice: "Could not unfavorite the #{@event.subject.class}"
    end
  end

  private
    def favorite_params
      {
        user: current_user,
        action: 'favorite',
        subject_id: params[:id],
        subject_type: 'Toot'
      }
    end
end
