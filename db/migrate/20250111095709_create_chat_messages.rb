class CreateChatMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_messages do |t|
      t.text :prompt
      t.text :response

      t.timestamps
    end
  end
end
