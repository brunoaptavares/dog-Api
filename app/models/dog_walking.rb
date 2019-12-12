class DogWalking < ApplicationRecord
  include AASM

  belongs_to :provider
  has_and_belongs_to_many :pets

  validates :status, :schedule_date, :price, :duration, :latitude, :longitude,
            presence: true

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
    return 0 if self.end_date.blank? || self.ini_date.blank?
    ((self.end_date - self.ini_date) / 60).round
  end

  private

  def start_walk
    self.ini_date = Time.current
  end

  def end_walk
    self.end_date = Time.current
  end
end
