class Chat < ApplicationRecord
  self.table_name = "chat"

  belongs_to :chat_application
  has_many :messages, dependent: :destroy

  validates :name, presence: true

  def as_json(options)
    super(:only => [:chat_id, :name, :messages_count])
  end
end
