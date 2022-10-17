class CreateChatTable < ActiveRecord::Migration[5.2]
  def change
    create_table :chat do |t|
      t.integer :chat_id, null: false
      t.bigint :chat_application_id, null: false

      t.string :name, null: false
      t.integer :messages_count, default: 0

      t.index [:chat_id, :chat_application_id], unique: true
    end

    add_foreign_key :chat, :chat_application, column: :chat_application_id, primary_key: :id, on_delete: :cascade

  end
end
