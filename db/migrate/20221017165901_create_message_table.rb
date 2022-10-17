class CreateMessageTable < ActiveRecord::Migration[5.2]
  def change
    create_table :message do |t|
      t.integer :message_id, null: false
      t.bigint :chat_id, null: false

      t.text :content, null: false
      t.timestamps

      t.index [:message_id, :chat_id], unique: true
    end

    add_foreign_key :message, :chat, column: :chat_id, primary_key: :id, on_delete: :cascade

  end
end
