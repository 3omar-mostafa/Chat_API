FactoryBot.define do
  factory :chat do
    sequence(:name) { |n| "chat_#{n}" }
  end
end
