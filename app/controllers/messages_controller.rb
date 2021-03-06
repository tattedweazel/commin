class MessagesController < ApplicationController
  # Probably wont use this - quicker to send and receive on the websocket channel
  before_action :authenticate_user!

  def index
    render '/messages/index'
  end

  def create
    message = Message.new(message_params)
    if message.save
      ActionCable.server.broadcast 'messages',
                                   body: message.body,
                                   room: message.room
      head :ok
    end
  end

  def get_latest_messages
    # the messages are sorted in reverse order, so first is the last message sent
    if room.messages.any?
      render(json: room.messages.first(40).sort_by { |e| e.created_at })
    else
      render(json: [])
    end
  end

  def message_params
    @message_params ||= params.require(:message).permit(:username, :body, :room)
  end

  private if Rails.env.production?

  def room
    @room ||= begin
      Room.search_by(name: params[:room].strip).first || Room.search_or_create_by(name: params[:room].strip, created_by: current_user.username)
    end
  end


end
