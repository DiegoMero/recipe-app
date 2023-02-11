FactoryBot.define do
  factory :user do
    id { 10 }
    email { 'test@example.com' }
    password { 'password' }
    name { 'David' }
  end
end
