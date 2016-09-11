class Favorite < ApplicationRecord
  belongs_to :toot, inverse_of: :favorites
  belongs_to :user, inverse_of: :favorites
end
