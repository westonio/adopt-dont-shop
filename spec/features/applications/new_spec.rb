require 'rails_helper'

RSpec.describe "Applications New Page", type: :feature do
  describe "I am taken to '/applications/new' where I see a form" do
    before :each do
      visit '/applications/new'
    end

    it "Has a field for the name" do
      expect(page).to have_field(:name)
      expect(page).to have_content("Name:")
    end

    it "has fields for the address" do
      expect(page).to have_field(:street_address)
      expect(page).to have_content("Street Address:")
      expect(page).to have_field(:city)
      expect(page).to have_content("City:")
      expect(page).to have_field(:state)
      expect(page).to have_content("State:")
      expect(page).to have_field(:zip_code)
      expect(page).to have_content("Zip Code:")
    end

    it "has a field for describing why the applicant would make a good home" do
      expect(page).to have_field(:description)
      expect(page).to have_content("Tell us why you would make a good home:")
    end

    describe "After filling out ALL fields in the form and clicking submit" do
      it 'redirects to the application show page and shows status "In Progress"' do
        within("#new_application") do
          fill_in :name, with: "Michelle Visage"
          fill_in :street_address, with: "4141 East 9th Avenue"
          fill_in :city, with: "Denver"
          fill_in :state, with: "Colorado"
          fill_in :zip_code, with: "80220"
          fill_in :description, with: "I would be a great home because I am rich and would take the pet(s) with me everywhere I go."
        end
    
        click_button "Save"
    
        expect(page).to have_content("Status: In Progress")
        expect(page).to have_content("Name: Michelle Visage")
        expect(page).to have_content("I would be a great home because I am rich and would take the pet(s) with me everywhere I go.")
      end
    end
    
    describe "Invalid / incomplete submission of the form" do
      it 'redirects to "applications/new"' do
        click_button "Save"
    
        expect(page).to have_current_path("/applications/new")
        expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank, Description can't be blank")
      end
    end
  end
end