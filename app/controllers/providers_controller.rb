class ProvidersController < ApplicationController
  before_action :set_provider, only: %i[show update]

  # GET /providers
  def index
    paginate json: Provider.all
  end

  # GET /providers/1
  def show
    render json: @provider
  end

  # POST /providers
  def create
    @provider = Provider.new(provider_params)

    if @provider.save
      render json: @provider, status: :created
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /providers/1
  def update
    if @provider.update(provider_params)
      render json: @provider, status: :ok
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  private

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name, :document)
  end
end
