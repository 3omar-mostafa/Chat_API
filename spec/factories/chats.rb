FactoryBot.define do
  factory :chat do
    sequence(:name) { |n| "chat_#{n}" }
    sequence :chat_id
  end
end
