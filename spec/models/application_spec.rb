require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

describe "validations" do
  it {should validate_presence_of :name}
  it {should validate_presence_of :street_address}
  it {should validate_presence_of :city}
  it {should validate_presence_of :state}
  it {should validate_presence_of :zip_code}
  it {should validate_presence_of :description}
  it {should validate_inclusion_of(:status).in_array(["In Progress", "Pending", "Accepted", "Rejected"])}
end

  describe "instance methods" do
    
    let!(:app_1) { Application.create!(name: "Bob", street_address: "466 Birch Road", city: "Birmingham", state: "Alabama", zip_code: "35057", description: "description", status: "Pending" ) }
    let!(:shelter1) { Shelter.create!(name:"Paws without Laws", foster_program: false, city: "Denver", rank: 3) }
    let!(:pet_1) { shelter1.pets.create!(name: "Matt", age: 14, breed: "Cat", adoptable: true) }
    let!(:pet_app_1) { PetApplication.create!(pet_id: pet_1.id, application_id: app_1.id) } 
  
    
    describe "#full_address" do
      it "formats full addresses" do
        expect(app_1.full_address).to eq("466 Birch Road Birmingham, Alabama, 35057")
      end
    end

    it 'finds a relevant pet_application' do
      expect(app_1.find_pet_app(pet_1.id)).to eq(pet_app_1)
    end
  end
end
