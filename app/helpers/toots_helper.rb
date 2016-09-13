module TootsHelper
  def user_has_favorited(toot)
    current_user && current_user.events.where(action: 'favorite', subject: toot).exists?
  end

  # Return the given string with any @mentions replaced with a link to that
  # user's profile.
  # NOTE: This is *definitely* not the best way to do this. Ideally, user
  # handles would make valid URLs, and no lookups would be necessary. A JS
  # script could simply wrap @mentions with `a` tags using the handle.
  def with_mentions text
    text.gsub(/@\w+/) do |handle|
      puts handle
      "<a class='at-mention' href=\"#{user_path(User.where(handle: handle[1..-1]).first)}\">#{handle}</a>"
    end.html_safe
  end
end
