require 'elasticsearch'
require 'elasticsearch/model'

conf = {
  host: ENV.fetch("ELASTIC_SEARCH_HOST", "localhost"),
  port: ENV.fetch("ELASTIC_SEARCH_PORT", 9200)
}

Elasticsearch::Model.client = Elasticsearch::Client.new(conf)

# Create Index for old data if does not exist
unless Message.__elasticsearch__.index_exists?
  Message.__elasticsearch__.create_index!
  Message.__elasticsearch__.import
end
