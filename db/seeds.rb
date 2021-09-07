# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Rating.destroy_all
Incident.destroy_all
Contact.destroy_all

user1 = User.create!(first_name: "Steve", last_name: "Watros", email: "steve@gg.com", password: "123456", phone_number: "+34607852370", emergency_number: "911")
user2 = User.create!(first_name: "Carlos", last_name: "Montesinos", email: "carlos@gg.com", password: "123456", phone_number: "+34607852370", emergency_number: "112")
user3 = User.create!(first_name: "Loulou", last_name: "Goldfarb", email: "loulou@gg.com", password: "123456", phone_number: "+34607852370", emergency_number: "112")
user4 = User.create!(first_name: "Alex", last_name: "Gorina", email: "alex@gg.com", password: "123456", phone_number: "+34607852370", emergency_number: "112")

Incident.create!(crime: "Stalking", user: user1, location: "Travessera de Gràcia, 250, 08025 Barcelona")
Incident.create!(crime: "Stalking", user: user2, location: "Carrer de Roger de Flor, 303, 08025 Barcelona")
Incident.create!(crime: "Harrassment", user: user3, location: "C. de Nàpols, 345, 08025 Barcelona")
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Pare Laínez, 28, 08025 Barcelona")

Incident.create!(crime: "Pickpocket", user: user1, location: "Carrer de Sicília, 386, 08025 Barcelona")
Incident.create!(crime: "Pickpocket", user: user2, location: "Carrer de la Indústria, 52, 08025 Barcelona")
Incident.create!(crime: "Assault", user: user3, location: "Carrer de la Indústria, 48, 08025 Barcelona")
Incident.create!(crime: "Assault", user: user4, location: "Travessera de Gràcia, 262, 08025 Barcelona")

Rating.create!(dimension: "Light", user: user1, latitude: 41.40610608427133, longitude: 2.1651689346373857, is_good: true)
Rating.create!(dimension: "Light", user: user2, latitude: 41.4067458225922, longitude: 2.164844387343024, is_good: true)
Rating.create!(dimension: "Crowd", user: user3, latitude: 41.4066894936859, longitude: 2.166048699206698, is_good: false)
Rating.create!(dimension: "Crowd", user: user4, latitude: 41.40573591835458, longitude: 2.1668801840048757, is_good: false)

Contact.create!(user: user1, first_name: "Carlos", last_name: "Montesinos", phone_number: "+34634530217")
Contact.create!(user: user2, first_name: "Steve", last_name: "Watros", phone_number: "+34607852370")
Contact.create!(user: user3, first_name: "Alex", last_name: "Gorina", phone_number: "+34627841248")
Contact.create!(user: user4, first_name: "Loulou", last_name: "Goldfarb", phone_number: "+34631694579")
