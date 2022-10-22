class Message < ApplicationRecord
  self.table_name = "message"

  belongs_to :chat

  validates :content, presence: true

  # Create elasticsearch index for this model
  include Elasticsearch::Model
  # Update the Elasticsearch index when a message is created or updated or deleted
  include Elasticsearch::Model::Callbacks

  # Create different elasticsearch index name for each environment
  # This is to avoid conflicts when running tests
  index_name [Rails.env, 'messages'].join('_')

  settings index: { number_of_shards: 1 } do
    mappings dynamic: false do
      indexes :message_id, type: :long
      indexes :content, type: :text
      indexes :chat_id, type: :long
    end
  end

  def as_json(options = {})
    if options[:only].blank?
      options[:only] = [:message_id, :content]
    end
    super(:only => options[:only])
  end

  def as_indexed_json(_options = {})
    _options[:only] = [:message_id, :content, :chat_id]
    as_json(_options)
  end

  def self.search(query, options = {})

    @search_definition = {
      query: {
        bool: {
          must: [
            {
              wildcard: {
                content: "*#{query[:q]}*",
              },
            },
            match: {
              chat_id: query[:chat_id]
            }
          ]
        }
      }
    }

    @search_definition[:_source] = [:message_id, :content]
    result = __elasticsearch__.search(@search_definition)
    result.map {|r| r[:_source]}
  end

  def self.redis_message_count_key(chat_id)
    "#{Chat.to_s}_#{chat_id}"
  end

end
