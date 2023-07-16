require "rails_helper"

RSpec.describe "admin shelters index page" do

  let!(:app_1) { Application.create!(name: "Bob", street_address: "466 Birch Road", city: "Birmingham", state: "Alabama", zip_code: "35057", description: "description", status: "In Progress" ) }
  let!(:app_2) { Application.create!(name: "Tina Belcher", street_address: "466 Albion Street", city: "New York", state: "New York", zip_code: "10001", description: "We have lots of fun", status: "Pending" ) }
  let!(:shelter_1) { Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9) }
  let!(:shelter_2) { Shelter.create(name: "RGV animal shelter", city: "Harlingen, TX", foster_program: false, rank: 5) }
  let!(:shelter_3) { Shelter.create(name: "Fancy pets of Colorado", city: "Denver, CO", foster_program: true, rank: 10) }
  let!(:pet_1) { shelter_1.pets.create(name: "Mr. Pirate", breed: "tuxedo shorthair", age: 5, adoptable: true) }
  let!(:pet_2) { shelter_1.pets.create(name: "Clawdia", breed: "shorthair", age: 3, adoptable: true) }
  let!(:pet_3) { shelter_3.pets.create(name: "Lucille Bald", breed: "sphynx", age: 8, adoptable: true) }
  let!(:pet_app_1) { PetApplication.create!(pet_id: pet_1.id, application_id: app_2.id) } 


  before do
    visit "/admin/shelters"
  end
  
  
  
  it "has a section for Shelters with Pending Applications" do
    within(".shelters_with_pending_applications") do
      expect(page).to have_content("Shelters with Pending Applications")
      expect(page).to have_content(shelter_1.name)
      expect(page).to_not have_content(shelter_2.name)
    end
  end
end