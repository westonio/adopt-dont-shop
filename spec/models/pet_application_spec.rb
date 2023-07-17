require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :application }
  end

  describe "validations" do
  it {should validate_presence_of :pet_id}
  it {should validate_presence_of :application_id}
  it {should validate_inclusion_of(:status).in_array(["Pending", "Accepted", "Rejected"])}
  end
end
