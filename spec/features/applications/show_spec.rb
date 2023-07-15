require "rails_helper"

RSpec.describe "applications show page" do
  let!(:app_1) { Application.create!(name: "Bob", street_address: "466 Birch Road", city: "Birmingham", state: "Alabama", zip_code: "35057", description: "description", status: "In Progress" ) }
  let!(:shelter1) { Shelter.create!(name:"Paws without Laws", foster_program: false, city: "Denver", rank: 3) }
  let!(:pet_1) { shelter1.pets.create!(name: "Matt", age: 14, breed: "Cat", adoptable: true) }
  let!(:pet_2) { shelter1.pets.create!(name: "Pog", age: 14, breed: "Dog", adoptable: true) }
  let!(:pet_app_1) { PetApplication.create!(pet_id: pet_1.id, application_id: app_1.id) } 
  let!(:pet_app_2) { PetApplication.create!(pet_id: pet_2.id, application_id: app_1.id) } 

  before do
    visit "/applications/#{app_1.id}"
  end

  it "displays application information" do
    save_and_open_page
    expect(page).to have_content("#{app_1.name}")
    expect(page).to have_content("466 Birch Road Birmingham, Alabama, 35057")
    expect(page).to have_content("#{app_1.description}")
    expect(page).to have_content("#{app_1.status}")
    expect(page).to have_link(pet_1.name)
    expect(page).to have_link(pet_2.name)
    click_link pet_1.name
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end


end