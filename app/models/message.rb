# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  sender_id  :bigint           not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_messages_on_sender_id  (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (sender_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :sender, class_name: :User

  validates :content, presence: true
end
