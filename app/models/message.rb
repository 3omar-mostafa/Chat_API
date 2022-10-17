class Message < ApplicationRecord
  self.table_name = "message"

  belongs_to :chat

  validates :content, presence: true

  def as_json(options)
    super(:only => [:message_id, :content, :created_at, :updated_at])
  end

end
