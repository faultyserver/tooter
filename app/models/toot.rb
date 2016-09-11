class Toot < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :toots
  has_many :events, as: :subject

  default_scope { order(created_at: :desc) }

  validates_presence_of :body
end
