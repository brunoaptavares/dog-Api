class DogWalkingsController < ApplicationController
  before_action :set_dog_walking,
                only: %i[show start_walk finish_walk cancel_walk]

  PROXIMOS = '1'.freeze

  # GET /dog_walkings
  def index
    paginate json: dog_walkings
  end

  # GET /dog_walkings/1
  def show
    render json: @dog_walking, methods: :actual_duration
  end

  # POST /dog_walkings
  def create
    @dog_walking = DogWalking.new(dog_walking_params)
    pet_dog_walking_params.map do |pet|
      @dog_walking.pets << Pet.find(pet[:id])
    end

    if @dog_walking.save
      render json: @dog_walking, status: :created
    else
      render json: @dog_walking.errors, status: :unprocessable_entity
    end
  end

  # POST /dog_walkings/1/start_walk
  def start_walk
    @dog_walking.started!
    success_return
  rescue AASM::InvalidTransition => e
    error_return(e)
  end

  # POST /dog_walkings/1/finish_walk
  def finish_walk
    @dog_walking.finished!
    success_return
  rescue AASM::InvalidTransition => e
    error_return(e)
  end

  # POST /dog_walkings/1/cancel_walk
  def cancel_walk
    @dog_walking.cancelled!
    success_return
  rescue AASM::InvalidTransition => e
    error_return(e)
  end

  private

  def filter_param
    params[:filter]
  end

  def dog_walkings
    return DogWalking.next_walks if filter_param == PROXIMOS

    DogWalking.all
  end

  def set_dog_walking
    @dog_walking = DogWalking.find(params[:id])
  end

  def dog_walking_params
    params.require(:dog_walking).
      permit(:schedule_date, :duration, :latitude, :longitude, :provider_id)
  end

  def pet_dog_walking_params
    params.require(:dog_walking).require(:pets)
  end

  def success_return
    render json: { success: 'operation success' }, status: :ok
  end

  def error_return(exception)
    render json: { error: exception.message }, status: :error
  end
end
