class Api::V1::ChatApplicationsController < Api::V1::ApplicationController
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
    InsertDataWorker.perform_async(ChatApplication.to_s, params!)
    chat_app = params!
    render json: chat_app, status: :created
  end

  # PATCH/PUT /applications/:token
  def update
    chat_app = params!(:name)
    UpdateDataWorker.perform_async(ChatApplication.to_s, @chat_app.id, chat_app)
    render json: chat_app, status: :ok
  end

  # DELETE /applications/:token
  def destroy
    DeleteDataWorker.perform_async(ChatApplication.to_s, @chat_app.id)
    render json: { message: "Chat application deleted" }, status: :ok
  end

  ####################################################################################################

  private

    def params!(*args)
      args = [:name, :token] if args.empty?
      params.permit(*args)
    end

    def require_params(args: :name)
      params.require(*args)
    end
end
