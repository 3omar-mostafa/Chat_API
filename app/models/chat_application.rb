class ChatApplication < ApplicationRecord
  self.table_name = "chat_application"

  has_many :chats, dependent: :destroy

  validates :name, presence: true
  validates :token, presence: true, uniqueness: true

  def as_json(options)
    super(:only => [:token, :name, :chats_count])
  end
end
