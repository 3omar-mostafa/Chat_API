class MessagesController < ApplicationController
  before_action :set_chat_application
  before_action :set_chat
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :require_params, only: [:create, :update]

  # GET /applications/:token/chats/:chat_id/messages
  def index
    render json: @messages = @chat.messages, status: :ok
  end

  # GET /applications/:token/chats/:chat_id/messages/:message_id
  def show
    render json: @message, status: :ok
  end

  # POST /applications/:token/chats/:chat_id/messages
  def create
    params[:message_id] = get_next_message_id
    @message = @chat.messages.new(params!(:content, :message_id))
    if @message.save
      @chat.messages_count += 1
      @chat.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :bad_request
    end
  end

  # PATCH/PUT /applications/:token/chats/:chat_id/messages/:message_id
  def update
    if @message.update(params!(:content))
      render json: @message, status: :ok
    else
      render json: @message.errors, status: :bad_request
    end
  end

  # DELETE /applications/:token/chats/:chat_id/messages/:message_id
  def destroy
    @message.destroy
    @chat.messages_count -= 1
    @chat.save
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
      args = [:token, :chat_id, :message_id, :content] if args.empty?
      params.permit(*args)
    end

    def require_params(args: :message)
      params.require(*args)
    end

    def get_next_message_id
      #TODO: Change This to more efficient method
      last = @chat.messages.last
      last ? last.message_id + 1 : 1
    end
end
