class Pet < ApplicationRecord
  belongs_to :client

  has_and_belongs_to_many :dog_walkings

  validates :name, :breed, presence: true
end
