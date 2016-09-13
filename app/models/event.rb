class Event < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  default_scope { order(created_at: :desc) }

  def self.stream_for_user user
    followed_users = user.following.map(&:subject_id)
    Event.where(user: followed_users).or(Event.where(subject: user)).includes(:subject)
  end
end
