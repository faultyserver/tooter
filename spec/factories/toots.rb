FactoryGirl.define do
  factory :toot do
    body { Faker::Hipster.sentence(10, false, 0) }
    author

    factory :toot_with_favorites do
      transient{ favorite_count 5 }

      after(:create) do |toot, opts|
        create_list(:favorite, opts.favorite_count, toot: toot)
      end
    end
  end
end
