class Application < ApplicationRecord
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def full_address
    street_address + " " + city + ", " + state + ", " + zip_code
  end

end

