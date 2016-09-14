module ApplicationHelper
  def render_event event
    # Don't render events that meet specific criteria
    if event.subject.is_a?(Toot) && event.user == event.subject.author
      return unless event.action == 'toot'
    end

    # If none of those criteria were met, go ahead and render the event
    content_tag(:div, class: 'event') do
      render "events/#{event.action}", event: event
    end
  end
end
