# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
PetApplication.destroy_all
Application.destroy_all
Pet.destroy_all
Shelter.destroy_all
Veterinarian.destroy_all
VeterinaryOffice.destroy_all

# Vet Offices and Veterinarians
@vet_office1 = VeterinaryOffice.create!(name: "Peak Veterinary Clinic", boarding_services: true, max_patient_capacity: 12)
  @vet_office1.veterinarians.create!(name: "Manila Luzon", on_call: false, review_rating: 4)
  @vet_office1.veterinarians.create!(name: "Latrice Royale", on_call: true, review_rating: 5)
  @vet_office1.veterinarians.create!(name: "Monet Exchange", on_call: true, review_rating: 4)
  @vet_office1.veterinarians.create!(name: "Evy Oddly", on_call: false, review_rating: 5)
  @vet_office1.veterinarians.create!(name: "Lemon", on_call: true, review_rating: 4)
  @vet_office1.veterinarians.create!(name: "Trinity The Tuck", on_call: true, review_rating: 4)

@vet_office2 = VeterinaryOffice.create!(name: "Paws4Life Hospital", boarding_services: false, max_patient_capacity: 15)
  @vet_office2.veterinarians.create!(name: "Ginger Minj", on_call: false, review_rating: 4)
  @vet_office2.veterinarians.create!(name: "Naomi Smalls", on_call: true, review_rating: 3)
  @vet_office2.veterinarians.create!(name: "Bianca Del Rio", on_call: true, review_rating: 5)
  @vet_office2.veterinarians.create!(name: "Sasha Colby", on_call: true, review_rating: 4)

  # Shelters and Pets

  @shelter1 = Shelter.create!(name:"Paws without Laws", foster_program: false, city: "Denver", rank: 3)
    @shelter1.pets.create!(name: "Matt", age: 14, breed: "Cat", adoptable: true)
    @shelter1.pets.create!(name: "Pog", age: 14, breed: "Dog", adoptable: true)
    @shelter1.pets.create!(name: "Trotter", age: 14, breed: "Otter", adoptable: true)
    @shelter1.pets.create!(name: "Morse", age: 14, breed: "Horse", adoptable: false)
    @shelter1.pets.create!(name: "Murtle", age: 14, breed: "Turtle", adoptable: true)
    @shelter1.pets.create!(name: "Leslie", age: 14, breed: "Lion", adoptable: true)
  @shelter2 = Shelter.create!(name:"Colorado Puppy Rescue", foster_program: true, city: "Denver", rank: 1)
    @shelter2.pets.create!(name: "Mator", age: 14, breed: "Gator", adoptable: true)
    @shelter2.pets.create!(name: "Teal", age: 14, breed: "Seal", adoptable: false)
    @shelter2.pets.create!(name: "Timmy", age: 14, breed: "Tiger", adoptable: true)