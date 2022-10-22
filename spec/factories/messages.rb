FactoryBot.define do
  factory :message do
    sequence(:content) { |n| "msg_#{n}" }
    sequence :message_id

    after(:create) do |msg|
      # refresh index to make sure the data is available for search
      # https://www.elastic.co/guide/en/elasticsearch/guide/current/near-real-time.html#refresh-api
      # Elasticsearch refreshes the index automatically every second by default , but we need to refresh it manually in tests
      Message.__elasticsearch__.refresh_index!
    end

  end
end
