class Api::V1::ApplicationController < ActionController::API
  ActionDispatch::PublicExceptions
  rescue_from Exception, with: :handle_error

  def handle_error(error)
    @errors_map ||= ActionDispatch::ExceptionWrapper.rescue_responses
    status = :internal_server_error

    if @errors_map.has_key?(error.class.name)
      status = @errors_map[error.class.name]
    end

    render json: { status: "error", message: error.message }, status: status, skip_status: true
  end

  def render(*args)
    args = args.first
    # skip_status: skip adding status to json response
    if args[:skip_status]
      return super args
    end

    # if status.is_a?(Symbol)
    #   status = Rack::Utils::SYMBOL_TO_STATUS_CODE[args[:status]]
    # end
    # if status.is_a?(Integer)
    #   status = Rack::Utils::HTTP_STATUS_CODES[args[:status]]
    # end
    super json: { status: "success", data: args[:json] }, status: args[:status]
  end

  protected

    def set_chat_application
      @chat_app ||= ChatApplication.find_by_token(params[:token])
      unless @chat_app
        raise ActiveRecord::RecordNotFound, "Chat Application '#{params[:token]}' is not found"
      end
    end

    def set_chat
      @chat ||= @chat_app.chats.find_by_chat_id(params[:chat_id])
      unless @chat
        raise ActiveRecord::RecordNotFound, "Chat '#{params[:chat_id]}' is not found"
      end
    end

    def set_message
      @message ||= @chat.messages.find_by_message_id(params[:message_id])
      unless @message
        raise ActiveRecord::RecordNotFound, "Message '#{params[:message_id]}' is not found"
      end
    end

end
