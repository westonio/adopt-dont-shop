require "rails_helper"

RSpec.describe "applications show page" do
  let!(:app_1) { Application.create!(name: "Bob", street_address: "466 Birch Road", city: "Birmingham", state: "Alabama", zip_code: "35057", description: "description", status: "In Progress" ) }
  let!(:app_2) { Application.create!(name: "Tina Belcher", street_address: "466 Albion Street", city: "New York", state: "New York", zip_code: "10001", description: "We have lots of fun", status: "In Progress" ) }
  let!(:shelter1) { Shelter.create!(name:"Paws without Laws", foster_program: false, city: "Denver", rank: 3) }
  let!(:pet_1) { shelter1.pets.create!(name: "Matt", age: 14, breed: "Cat", adoptable: true) }
  let!(:pet_2) { shelter1.pets.create!(name: "Pog", age: 14, breed: "Dog", adoptable: true) }
  let!(:pet_3) { shelter1.pets.create!(name: "Anetra", age: 3, breed: "Leopard Gecko", adoptable: true) }
  let!(:pet_4) { shelter1.pets.create!(name: "Alaska", age: 6, breed: "Cat", adoptable: true) }
  let!(:pet_app_1) { PetApplication.create!(pet_id: pet_1.id, application_id: app_1.id) } 
  let!(:pet_app_2) { PetApplication.create!(pet_id: pet_2.id, application_id: app_1.id) } 
  
  before do
    visit "/applications/#{app_1.id}"
  end

  it "displays application information" do
    expect(page).to have_content("Name: #{app_1.name}")
    expect(page).to have_content("466 Birch Road Birmingham, Alabama, 35057")
    expect(page).to have_content("Description: #{app_1.description}")
    expect(page).to have_content("Status: #{app_1.status}")
    expect(page).to have_link(pet_1.name)
    expect(page).to have_link(pet_2.name)
    click_link pet_1.name
    expect(current_path).to eq("/pets/#{pet_1.id}")
  end

  it "has a field for searching by pet name" do
    within(".add_pet_to_application") do
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field(:name)
      fill_in "Search By Pet's Name", with: pet_3.name
      click_button "Search"
      expect(current_path).to eq("/applications/#{app_1.id}")
      expect(page).to have_content(pet_3.name)
    end
  end

  it "has a button to adopt pet; when clicked pet is added to the application" do
    within(".add_pet_to_application") do
      fill_in "Search By Pet's Name", with: pet_3.name
      click_button "Search"
      expect(page).to have_content("Adopt #{pet_3.name}")
      click_button "Adopt #{pet_3.name}"
      expect(current_path).to eq("/applications/#{app_1.id}")
      expect(page).to_not have_content(pet_3.name)
    end
    within(".application_information") do
      expect(page).to have_content(pet_3.name)
    end
  end

  describe "submitting an application" do
    it 'has no Submit Application button until pets are added' do
      visit "/applications/#{app_2.id}"
      expect(page).to_not have_button("Submit Application")
    end
  
    context "after at least 1 pet is added" do
      it 'has a field to update the description of being a good home/owners' do
        visit "/applications/#{app_2.id}"
        
        within(".add_pet_to_application") do
          fill_in "Search By Pet's Name", with: pet_3.name
          click_button "Search"
          click_button "Adopt #{pet_3.name}"
        end
        
        expect(page).to have_content("Description: #{app_2.description}")
      end

      it 'has a "Submit Application" button' do
        visit "/applications/#{app_2.id}"
        
        within(".add_pet_to_application") do
          fill_in "Search By Pet's Name", with: pet_3.name
          click_button "Search"
          click_button "Adopt #{pet_3.name}"
        end
      
        expect(page).to have_button("Submit Application")
      end

      it 'redirects show page with updated description' do
        #visiting app_1 (already has two pets added)
        within(".application_information") do
          fill_in :description, with: "New description"
          click_button("Submit Application")
        end

        expect(current_path).to eq("/applications/#{app_1.id}")
        expect(page).to have_content("New description")
      end

      it 'shows an indicator that the application is "Pending"' do
        click_button("Submit Application")

        expect(page).to have_content("Status: Pending")
      end

      it 'redirects and shows the pets names' do
        #visiting app_1 (already has two pets added)
        click_button("Submit Application")

        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(pet_2.name)
      end

      it 'redirects and no longer shows the bar to search for pets' do
        #visiting app_1 (already has two pets added)
        click_button("Submit Application")

        expect(page).to_not have_content("Add a Pet to this Application")
      end
    end
  end

  it "returns partial matches in pet name search" do
    fill_in "Search By Pet's Name", with: "a"
    click_button "Search"
    expect(page).to have_content(pet_3.name)
    expect(page).to have_content(pet_4.name)
  end

  it "is not case sensitive" do
    fill_in "Search By Pet's Name", with: "ANETRA"
    click_button "Search"
    expect(page).to have_content(pet_3.name)
    fill_in "Search By Pet's Name", with: "anetra"
    click_button "Search"
    expect(page).to have_content(pet_3.name)
  end
end