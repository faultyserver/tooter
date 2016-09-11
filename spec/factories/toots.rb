FactoryGirl.define do
  factory :toot do
    body { Faker::Hipster.sentence(10, false, 0) }
    author
  end
end
