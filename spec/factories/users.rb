FactoryGirl.define do
  factory :user, aliases: [:author] do
    handle    { Faker::Internet.user_name.split(/\W/).first }
    name      { Faker::Name.name }
    password  { Faker::Internet.password }
    bio       { "#{Faker::Name.title} at #{Faker::Company.name}. #{Faker::Hacker.ingverb} #{Faker::Hacker.noun} with #{Faker::Name.name}" }

    factory :user_with_toots do
      transient{ toot_count 5 }

      after(:create) do |user, opts|
        create_list(:toot, opts.toot_count, author: user)
      end
    end


    factory :user_with_favorites do
      transient{ favorite_count 5 }

      after(:create) do |user, opts|
        create_list(:favorite, opts.favorite_count, user: user)
      end
    end
  end
end
