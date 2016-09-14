class Event < ApplicationRecord
  # For the sake of simplicity, `initiator` can be considered `user`, since
  # most events will follow this pattern. However, some events (such as
  # mentions), are initiated by other objects (Toots), and so a polymorphic
  # association is necessary.
  belongs_to :initiator, polymorphic: true
  alias_attribute :user, :initiator

  belongs_to :subject, polymorphic: true

  default_scope { order(created_at: :desc) }

  def self.stream_for_user user
    followed_users = user.following.map(&:subject_id)
    Event.where(user: followed_users).or(Event.where(subject: user)).includes(:subject)
  end
end
