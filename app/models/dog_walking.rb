class DogWalking < ApplicationRecord
  include AASM

  belongs_to :provider
  has_and_belongs_to_many :pets

  validates :status, :schedule_date, :duration, :latitude, :longitude,
            presence: true

  default_scope { order(schedule_date: :asc) }
  scope :next_walks, lambda {
    where('dog_walkings.schedule_date > ?', Time.zone.today.beginning_of_day)
  }

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
end
