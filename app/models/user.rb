class User < ApplicationRecord
  has_many :toots, foreign_key: 'author_id', inverse_of: :author
end
