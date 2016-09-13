class Toot < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :toots
  has_many :events, as: :subject

  default_scope { order(created_at: :desc) }

  validates_presence_of :body

  after_create do
    Event.create(user: author, action: 'toot', subject: self)
  end

  after_destroy do
    Event.where(subject: self).delete_all
  end
end
