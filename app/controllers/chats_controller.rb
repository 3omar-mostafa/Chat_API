class ChatsController < ApplicationController
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
    @chat = @chat_app.chats.new(params!(:name, :chat_id))
    if @chat.save
      @chat_app.chats_count += 1
      @chat_app.save
      render json: @chat, status: :created
    else
      render json: @chat.errors, status: :bad_request
    end
  end

  # PATCH/PUT /applications/:token/chats/:chat_id
  def update
    if @chat.update(params!(:name))
      render json: @chat, status: :ok
    else
      render json: @chat.errors, status: :bad_request
    end
  end

  # DELETE /applications/:token/chats/:chat_id
  def destroy
    @chat.destroy
    @chat_app.chats_count -= 1
    @chat_app.save
    render json: { message: "Chat deleted" }, status: :ok
  end

  ####################################################################################################

  private

    def set_chat_application
      @chat_app ||= ChatApplication.find_by_token!(params[:token])
    end

    def set_chat
      @chat ||= @chat_app.chats.find_by_chat_id!(params[:chat_id])
    end

    def params!(*args)
      args = [:token, :name, :chat_id] if args.empty?
      params.permit(*args)
    end

    def require_params(args: :chat)
      params.require(*args)
    end

    def get_next_chat_id
      #TODO: Change This to more efficient method
      last = @chat_app.chats.last
      last ? last.chat_id + 1 : 1
    end
end
