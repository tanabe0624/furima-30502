FactoryBot.define do
  factory :address_info do
    zip_code { '123-4567' }
    prefectures_id { 5 }
    city { '大阪府' }
    street_number { '1-1' }
    phone_number { '09012345678' }
    building { '大阪ハイツ' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
