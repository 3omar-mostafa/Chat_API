class Message < ApplicationRecord
  self.table_name = "message"

  belongs_to :chat

  validates :content, presence: true

  # Create the index for this model
  include Elasticsearch::Model
  # Update the Elasticsearch index when a message is created or updated or deleted
  include Elasticsearch::Model::Callbacks

  settings index: { number_of_shards: 1 } do
    mappings dynamic: false do
      indexes :message_id, type: :long
      indexes :content, type: :text
      indexes :chat_id, type: :long
    end
  end

  def as_json(options)
    if options[:only].blank?
      options[:only] = [:message_id, :content]
    end
    super(:only => options[:only])
  end

  def as_indexed_json(_options: {})
    _options[:only] = [:message_id, :content, :chat_id]
    as_json(_options)
  end

  def self.search(query, options: {})

    if query[:q].blank?
      @search_definition = {
        query: {
          match: {
            chat_id: query[:chat_id]
          }
        }
      }
    else
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
    end

    @search_definition[:_source] = [:message_id, :content]
    result = __elasticsearch__.search(@search_definition)
    result.map {|r| r[:_source]}
  end


end
