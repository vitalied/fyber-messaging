class MessagesController < ApplicationController
  include Swaggers::MessagesController

  # GET /messages
  def index
    @messages = current_user.messages.unread.to_a
    read_at = Time.now
    current_user.recipients.update_all(read_at: read_at)

    render json: @messages, current_user: current_user, read_at: read_at
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.sender = current_user

    if @message.save
      render json: @message, status: :created, current_user: current_user
    else
      render_errors(@message.errors)
    end
  end

  private

  def message_params
    params.fetch(:message, {}).permit(:content, user_ids: [])
  end
end
