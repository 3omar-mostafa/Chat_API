class ChatApplicationsController < ApplicationController
  before_action :set_chat_application, only: [:show, :update, :destroy]
  before_action :require_params, only: [:create, :update]

  # GET /applications
  def index
    render json: @chat_apps = ChatApplication.all, status: :ok
  end

  # GET /applications/:token
  def show
    render json: @chat_app, status: :ok
  end

  # POST /applications
  def create
    params[:token] = SecureRandom.uuid
    @chat_app = ChatApplication.new(params!)
    if @chat_app.save
      render json: @chat_app, status: :created
    else
      render json: @chat_app.errors, status: :bad_request
    end
  end

  # PATCH/PUT /applications/:token
  def update
    if @chat_app.update(params!)
      render json: @chat_app, status: :ok
    else
      render json: @chat_app.errors, status: :bad_request
    end
  end

  # DELETE /applications/:token
  def destroy
    @chat_app.destroy
    render json: { message: "Chat application deleted" }, status: :ok
  end

  ####################################################################################################

  private

    def set_chat_application
      @chat_app ||= ChatApplication.find_by_token!(params[:token])
    end

    def params!(*args)
      args = [:name, :token] if args.empty?
      params.permit(*args)
    end

    def require_params(args: :chat_application)
      params.require(*args)
    end
end
