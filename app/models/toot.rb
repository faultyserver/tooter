class Toot < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :toots
  has_many :events, as: :subject

  default_scope { order(created_at: :desc) }

  validates_presence_of :body

  after_create{  Event.create(user: author, action: 'toot', subject: self) }
  after_destroy{ Event.where(subject: self).delete_all }
end
