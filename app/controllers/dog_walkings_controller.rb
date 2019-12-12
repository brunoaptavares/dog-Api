class DogWalkingsController < ApplicationController
  before_action :set_dog_walking, only: [:show, :start_walk, :finish_walk,
                                         :cancel_walk]

  # GET /dog_walkings
  def index
    @dog_walkings = DogWalking.all

    render json: @dog_walkings
  end

  # GET /dog_walkings/1
  def show
    render json: @dog_walking, :methods => :actual_duration
  end

  # POST /dog_walkings
  def create
    @dog_walking = DogWalking.new(dog_walking_params)

    if @dog_walking.save
      render json: @dog_walking, status: :created, location: @dog_walking
    else
      render json: @dog_walking.errors, status: :unprocessable_entity
    end
  end

  # POST /dog_walkings/1/start_walk
  def start_walk
    @dog_walking.started!
  end

  # POST /dog_walkings/1/finish_walk
  def finish_walk
    @dog_walking.finished!
  end

  # POST /dog_walkings/1/cancel_walk
  def cancel_walk
    @dog_walking.cancelled!
  end

  private

  def set_dog_walking
    @dog_walking = DogWalking.find(params[:id])
  end

  def dog_walking_params
    params.fetch(:dog_walking, {})
  end
end
