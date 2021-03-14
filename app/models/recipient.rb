# == Schema Information
#
# Table name: recipients
#
#  id         :bigint           not null, primary key
#  message_id :bigint           not null
#  user_id    :bigint           not null
#  read_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_recipients_on_message_id  (message_id)
#  index_recipients_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#  fk_rails_...  (user_id => users.id)
#
class Recipient < ApplicationRecord
  belongs_to :message
  belongs_to :user
end
