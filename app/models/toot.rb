class Toot < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :toots
  has_many :favorites, inverse_of: :toot

  default_scope { order(created_at: :desc) }

  validates_presence_of :body
end
