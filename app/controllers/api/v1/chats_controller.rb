class Api::V1::ChatsController < Api::V1::ApplicationController
  before_action :set_chat_application
  before_action :set_chat, only: [:show, :update, :destroy]
  before_action :require_params, only: [:create, :update]

  # GET /applications/:token/chats
  def index
    render json: @chats = @chat_app.chats, status: :ok
  end

  # GET /applications/:token/chats/:chat_id
  def show
    render json: @chat, status: :ok
  end

  # POST /applications/:token/chats
  def create
    params[:chat_id] = get_next_chat_id
    params[:chat_application_id] = @chat_app.id
    InsertDataWorker.perform_async(Chat.to_s, params!(:name, :chat_id, :chat_application_id))
    chat = params!(:name, :chat_id)
    render json: chat, status: :created
  end

  # PATCH/PUT /applications/:token/chats/:chat_id
  def update
    chat = params!(:name)
    UpdateDataWorker.perform_async(Chat.to_s, @chat.id, chat)
    render json: chat, status: :ok
  end

  # DELETE /applications/:token/chats/:chat_id
  def destroy
    DeleteDataWorker.perform_async(Chat.to_s, @chat.id)
    render json: { message: "Chat deleted" }, status: :ok
  end

  ####################################################################################################

  private

    def params!(*args)
      args = [:token, :name, :chat_id] if args.empty?
      params.permit(*args)
    end

    def require_params(args = :name)
      params.require(*args)
    end

    def get_next_chat_id
      Redis.new.incr(Chat.redis_chat_count_key(@chat_app.id))
    end
end
