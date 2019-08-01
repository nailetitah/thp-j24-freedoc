# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

medecines = ["Généraliste", "Dentiste", "Kinésithérapeute", "Osthéopate"]
cities = ["Paris", "Lille", "Marseille", "Lyon", "Bordeaux"]

Doctor.destroy_all
Patient.destroy_all
Appointment.destroy_all
City.destroy_all
Specialty.destroy_all
Expertise.destroy_all

(0..3).each do |index|
  specialty = Specialty.create(specialty: medecines[index])
  puts "La spécialité #{specialty.specialty} a été générée"
end

(0..4).each do |index|
  city = City.create(city: cities[index])
  puts "La ville de #{city.city} a été générée"
end

100.times do
  doctor = Doctor.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, zip_code: rand(00001...98990), city_id: rand(1..5))
end

puts "100 docteurs ont été créés !"

200.times do
  patient = Patient.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, city_id: rand(1..5))
end

puts "200 patients ont été créés !"

300.times do
  rand_doctor = Doctor.find(rand(1...101))
  doc_city_id = rand_doctor.city_id
  appointment = Appointment.create!(doctor: rand_doctor, patient: Patient.where(city_id: doc_city_id).sample, date: Time.at(rand * Time.now.to_i), city_id: doc_city_id )
end

puts "300 RDV ont été créés !"

100.times do
  expertise = Expertise.create!(doctor: Doctor.find(rand(1...101)), specialty: Specialty.find(rand(1..4)))
end
puts "La table des expertises a généré 100 entrées"


