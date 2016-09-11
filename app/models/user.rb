class User < ApplicationRecord
  has_many :toots, foreign_key: 'author_id', inverse_of: :author

  validates_uniqueness_of :handle
  validates_presence_of :handle, :name, :password
  validates :bio, length: { in: 0..200 }, allow_nil: false
  validates :password, length: { minimum: 8 }

  has_secure_password
end
