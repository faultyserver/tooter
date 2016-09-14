module TootsHelper
  def user_has_favorited(toot)
    current_user && current_user.events.where(action: 'favorite', subject: toot).exists?
  end

  # Return the given string with any @mentions replaced with a link to that
  # user's profile.
  def with_mentions text
    text.gsub(/(@)(\w+)/) do |handle|
      content_tag(:a, handle, class: 'at-mention', href: user_path(handle[1..-1]))
    end.html_safe
  end
end
