class Provider < ApplicationRecord
  has_many :pets
  has_many :dog_walkings

  validates :name, :document, presence: true
end
