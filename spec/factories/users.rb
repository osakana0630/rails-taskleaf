FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'test@test.com' }
    password_digest { 'password' }
  end
end
