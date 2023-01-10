FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.unique.email}
    password {'1a' + Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    last_name {'緒方'}
    first_name {'光琳'}
    last_name_kana {'オガタ'}
    first_name_kana {'コウリン'}
    birthday {Faker::Date.birthday}
  end
end