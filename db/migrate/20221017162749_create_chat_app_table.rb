class CreateChatAppTable < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_application do |t|
      t.string :token, null: false, :limit => 38
      t.string :name, null: false
      t.integer :chats_count, default: 0

      t.index :token, unique: true
    end
  end
end
