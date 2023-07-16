require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "instance methods" do
    
    let!(:app_1) { Application.create!(name: "Bob", street_address: "466 Birch Road", city: "Birmingham", state: "Alabama", zip_code: "35057", description: "description", status: "In Progress" ) }
    
    describe "#full_address" do
      it "formats full addresses" do
        expect(app_1.full_address).to eq("466 Birch Road Birmingham, Alabama, 35057")
      end
    end
  end
end
