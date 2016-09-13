class FollowsController < ApplicationController
  before_action :authorize

  # POST /users/:id/follow
  def create
    @event = Event.new(follow_params)

    if @event.save
      redirect_back(fallback_location: @event.subject)
    else
      redirect_back(fallback_location: @event.subject, notice: "Could not follow the #{@event.subject.class}")
    end
  end

  # POST /users/:id/unfollow
  def destroy
    @event = Event.find_by(follow_params)

    if @event.destroy
      redirect_back(fallback_location: @event.subject)
    else
      redirect_back(fallback_location: @event.subject, notice: "Could not unfollow the #{@event.subject.class}")
    end
  end

  private
    def follow_params
      {
        user: current_user,
        action: 'follow',
        subject_id: params[:id],
        subject_type: 'User'
      }
    end
end
