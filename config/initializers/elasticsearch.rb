require 'elasticsearch'
require 'elasticsearch/model'

if ENV['ELASTICSEARCH_URL'].blank?
  conf = {
    host: ENV['ELASTICSEARCH_HOST'],
    port: ENV['ELASTICSEARCH_PORT']
  }

  Elasticsearch::Model.client = Elasticsearch::Client.new(conf)
end

def database_exists?
  ActiveRecord::Base.connection
rescue ActiveRecord::NoDatabaseError
  false
else
  true
end

# Create Index for old data if does not exist

begin
  if database_exists? and not Message.__elasticsearch__.index_exists?
  Message.__elasticsearch__.create_index!
  Message.__elasticsearch__.import
  end
rescue
  puts "======================= Can not connect to elasticsearch ========================"
end
