class Pet < ApplicationRecord
  belongs_to :client

  has_many :dog_walkings

  validates :name, :breed, presence: true
end
