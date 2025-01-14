class ChatMessage < ApplicationRecord
  after_create_commit { broadcast_append_to :chat_messages }
  after_update_commit { broadcast_replace_to :chat_messages }
  after_destroy_commit { broadcast_remove_to :chat_messages }
end
