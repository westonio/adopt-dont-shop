class PetApplication < ApplicationRecord
  validates :pet_id, presence: true
  validates :application_id, presence: true
  validates :status, inclusion: { in: ["Pending", "Accepted", "Rejected"] }
  
  belongs_to :pet
  belongs_to :application
end
