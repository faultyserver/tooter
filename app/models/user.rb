class User < ApplicationRecord
  has_many :toots, foreign_key: 'author_id', inverse_of: :author
  has_many :events, inverse_of: :user
  has_many :subject_events, class_name: 'Event', as: :subject

  validates_uniqueness_of :handle
  validates_presence_of :handle, :name, :password
  validates :bio, length: { in: 0..200 }, allow_nil: false
  validates :password, length: { minimum: 8 }

  has_secure_password

  def event_stream
    events
  end
end
