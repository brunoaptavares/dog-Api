class DogWalking < ApplicationRecord
  include AASM

  belongs_to :provider
  has_and_belongs_to_many :pets

  validates :status, :schedule_date, :duration, :latitude, :longitude,
            presence: true
  validates :duration, inclusion: { in: [30, 60],
                                    message: 'duration must be 30 or 60 min' }

  default_scope { order(schedule_date: :asc) }
  scope :next_walks, lambda {
    where('dog_walkings.schedule_date > ?', Time.zone.today.beginning_of_day)
  }

  after_save :calculate_price

  aasm column: :status do
    state :scheduled, initial: true
    state :started
    state :finished
    state :cancelled

    event :started do
      transitions to: :started, from: :scheduled, after: :start_walk
    end

    event :finished do
      transitions to: :finished, from: :started, after: :end_walk
    end

    event :cancelled do
      transitions to: :cancelled, from: :scheduled
    end
  end

  def actual_duration
    return 0 if end_date.blank? || ini_date.blank?

    ((end_date - ini_date) / 60).round
  end

  private

  def start_walk
    self.ini_date = Time.current
  end

  def end_walk
    self.end_date = Time.current
  end

  def calculate_price
    return calculate_half_price if half_walk?

    return calculate_hour_price if hour_walk?
  end

  def calculate_half_price
    self.price =
      half_prices['first'] + (half_prices['additional'] * (pets.count - 1))
  end

  def calculate_hour_price
    self.price =
      hour_prices['first'] + (hour_prices['additional'] * (pets.count - 1))
  end

  def half_walk?
    duration == 30
  end

  def hour_walk?
    duration == 60
  end

  def half_prices
    AppConfig['prices']['half']
  end

  def hour_prices
    AppConfig['prices']['hour']
  end
end
