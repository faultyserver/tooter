FactoryGirl.define do
  factory :toot_event, class: Event, aliases: [:event] do
    user
    action 'toot'
    subject { create(:toot) }
  end

  factory :favorite_event, class: Event do
    user
    action 'favorite'
    subject { create(:toot) }
  end
end
