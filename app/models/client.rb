class Client < ApplicationRecord
  has_many :pets

  validates :name, :document, presence: true
end
