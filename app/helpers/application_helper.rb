module ApplicationHelper
  def render_event event
    render "events/#{event.action}", event: event
  end
end
