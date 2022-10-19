class ChatApplication < ApplicationRecord
  self.table_name = "chat_application"

  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  def as_json(options)
    super(:only => [:token, :name, :chats_count])
  end

  def self.update_count
    # `find_each` is more efficient that `all` because it query data in batches
    ChatApplication.find_each do |chat_app|
      # Using update_columns is the fastest way to update columns
      # Because it skips validations, callbacks and updating `updated_at` column
      # chat_app.chats_count = chat_app.chats.length
      chat_app.update_columns(:chats_count => chat_app.chats.size)
    end
  end

  def self.get_next_id(params)
    return {}
  end

  def delete_redis_data
    Redis.new.del(Chat.redis_chat_count_key(self.id))
    self.chats.each do |chat|
      chat.delete_redis_data
    end
  end

end
