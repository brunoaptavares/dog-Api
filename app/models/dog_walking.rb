class DogWalking < ApplicationRecord
  include AASM

  has_one :provider
  has_many :pets

  validates :status, :schedule_date, :price, :duration, :latitude, :longitude,
            :ini_date, :end_date, presence: true

  aasm :column => :status do
    state :scheduled, :initial => true
    state :finished
    state :cancelled

    event :finished do
      transitions :to => :finished, :from => :scheduled
    end

    event :cancelled do
      transitions :to => :cancelled, :from => :scheduled
    end
  end
end
