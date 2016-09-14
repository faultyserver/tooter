class User < ApplicationRecord
  has_many :toots, foreign_key: 'author_id', inverse_of: :author
  has_many :events, as: :initiator
  has_many :subject_events, class_name: 'Event', as: :subject

  validates :handle,    length: { in: 1..32   }, allow_nil: false, uniqueness: true
  validates :handle,    format: { with: /\A[a-zA-Z0-9_]+\z/i, message: 'Handles may only contain letters, numbers, and/or underscores' }
  validates :name,      length: { in: 1..64   }, allow_nil: false
  validates :bio,       length: { in: 0..200  }, allow_nil: true
  validates :password,  length: { minimum: 8  }, allow_nil: false

  has_secure_password

  def to_param
    handle
  end

  def event_stream
    events
  end

  def followers
    subject_events.where(action: 'follow')
  end

  def following
    events.where(action: 'follow')
  end

  def favorites
    events.where(action: 'favorite')
  end


  # Returns true if this User has favorited the given subject.
  def favorited? subject
    has_event? 'favorite', subject
  end

  # Returns true if this User is currently following the given subject.
  def following? subject
    has_event? 'follow', subject
  end

  private
    def has_event? action, subject
      events.where(action: action, subject: subject).exists?
    end
end
