FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category_id { '2' }
    condition_id { '2' }
    postage_id { '2' }
    region_id { '2' }
    shipping_date_id { '2' }
    price { '1000' }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
