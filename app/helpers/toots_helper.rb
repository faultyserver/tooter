module TootsHelper
  def user_has_favorited(toot)
    current_user && current_user.events.where(action: 'favorite', subject: toot).exists?
  end
end
