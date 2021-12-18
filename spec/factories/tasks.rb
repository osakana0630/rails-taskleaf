FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "Test Task #{n}" }
    description { 'Test Description' }
    association :user
  end
end
