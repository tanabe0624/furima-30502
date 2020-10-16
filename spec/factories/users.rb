FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    first_name {person.first.kanji}
    first_name_kana {person.first.katakana}
    family_name {person.last.kanji}
    family_name_kana {person.last.katakana}
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    birthday {Faker::Date.backward}
    password = "abc123"
    password { password }
    password_confirmation {password}
    
  end
end