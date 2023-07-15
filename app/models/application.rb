class Application < ApplicationRecord
  validates :name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :description, presence: true
  validates :status, inclusion: { in: ["In Progress", "Pending", "Accepted", "Rejected"] }

  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def full_address
    street_address + " " + city + ", " + state + ", " + zip_code
  end

end

