class MessagesController < ApplicationController
  before_action :set_chat_application
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :require_params, only: [:create, :update]

  # GET /applications/:token/chats/:chat_id/messages
  def index
    query = {
      q: params[:q],
      chat_id: @chat.id
    }
    render json: Message.search(query), status: :ok
  end

  # GET /applications/:token/chats/:chat_id/messages/:message_id
  def show
    render json: @message, status: :ok
  end

  # POST /applications/:token/chats/:chat_id/messages
  def create
    params[:message_id] = get_next_message_id
    params[:chat_id] = @chat.id
    InsertDataWorker.perform_async(Message.to_s, params!(:message_id, :chat_id, :content))
    message = params!(:message_id, :content)
    render json: message, status: :created
  end

  # PATCH/PUT /applications/:token/chats/:chat_id/messages/:message_id
  def update
    message = params!(:content)
    UpdateDataWorker.perform_async(Message.to_s, @message.id, message)
    render json: message, status: :ok
  end

  # DELETE /applications/:token/chats/:chat_id/messages/:message_id
  def destroy
    DeleteDataWorker.perform_async(Message.to_s, @message.id)
    render json: { message: "Message deleted" }, status: :ok
  end

  ####################################################################################################

  private

    def set_chat_application
      @chat_app ||= ChatApplication.find_by_token!(params[:token])
    end

    def set_chat
      @chat ||= @chat_app.chats.find_by_chat_id!(params[:chat_id])
    end

    def set_message
      @message ||= @chat.messages.find_by_message_id!(params[:message_id])
    end

    def params!(*args)
      args = [:token, :chat_id, :message_id, :content, :q] if args.empty?
      params.permit(*args)
    end

    def require_params(args: :content)
      params.require(*args)
    end

    def get_next_message_id
      Redis.new.incr(Message.redis_message_count_key(@chat.id))
    end

end
