class Event < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  default_scope { order(created_at: :desc) }

  def self.stream_for_user user
    Event.where(user: user).or(Event.where(subject: user))
  end
end
