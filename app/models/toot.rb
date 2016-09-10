class Toot < ApplicationRecord
  belongs_to :author, class_name: 'User', inverse_of: :toots

  validates_presence_of :body
end
