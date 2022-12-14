class Chat < ApplicationRecord
  self.table_name = "chat"

  belongs_to :chat_application
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  after_destroy_commit do |chat|
    Redis.new.del(Message.redis_message_count_key(chat.id))
  end

  def as_json(options = nil)
    super(:only => [:chat_id, :name, :messages_count])
  end

  def self.update_count
    # `find_each` is more efficient that `all` because it query data in batches
    Chat.find_each do |chat|
      # Using update_columns is the fastest way to update columns
      # Because it skips validations, callbacks and updating `updated_at` column
      # chat.messages_count = chat.messages.length
      chat.update_columns(:messages_count => chat.messages.size)
    end
  end

  def self.redis_chat_count_key(chat_application_id)
    "#{ChatApplication.to_s}_#{chat_application_id}"
  end

end
