class UpdateIndices < ActiveRecord::Migration[5.2]
  def change
    remove_index :chat, column: [:chat_id, :chat_application_id]
    add_index :chat, [:chat_application_id, :chat_id], unique: true

    remove_index :message, column: [:message_id, :chat_id]
    add_index :message, [:chat_id, :message_id], unique: true
  end
end
