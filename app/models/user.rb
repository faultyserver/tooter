class User < ApplicationRecord
  has_many :toots, foreign_key: 'author_id', inverse_of: :author
  has_many :events, inverse_of: :user
  has_many :subject_events, class_name: 'Event', as: :subject

  validates :handle,    length: { in: 1..32   }, allow_nil: false, uniqueness: true
  validates :name,      length: { in: 1..64   }, allow_nil: false
  validates :bio,       length: { in: 0..200  }, allow_nil: true
  validates :password,  length: { minimum: 8  }, allow_nil: false

  has_secure_password

  def event_stream
    events
  end
end
