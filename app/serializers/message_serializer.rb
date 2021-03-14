class MessageSerializer < ActiveModel::Serializer
  belongs_to :sender

  attributes :id, :content, :sent_at, :read_at

  def sent_at
    object.created_at.in_time_zone(@instance_options[:current_user]&.time_zone)
  end

  def read_at
    @instance_options[:read_at]&.in_time_zone(@instance_options[:current_user]&.time_zone)
  end
end
