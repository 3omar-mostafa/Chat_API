FactoryBot.define do
  factory :chat_application do
    sequence(:name) { |n| "chat_app_#{n}" }
    # We are not using secure random because we want to be able to test the token
    sequence(:token) { |n| "token_#{n}" }
  end
end
