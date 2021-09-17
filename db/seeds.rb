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

Incident.create!(crime: "Stalking", user: user1, location: "Passeig de Sant Joan, 144, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Stalking", user: user2, location: "Passeig de Sant Joan, 160, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user3, location: "Passeig de Sant Joan, 125, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Passeig de Sant Joan, 169, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Stalking", user: user1, location: "Passeig de Sant Joan, 144, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Stalking", user: user2, location: "Passeig de Sant Joan, 160, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user3, location: "Passeig de Sant Joan, 125, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Passeig de Sant Joan, 169, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')

Incident.create!(crime: "Stalking", user: user2, location: "Carrer de Roger de Flor, 229, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user3, location: "Carrer de Roger de Flor, 272, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Roger de Flor, 185, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Roger de Flor, 225, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Stalking", user: user2, location: "Carrer de Roger de Flor, 229, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user3, location: "Carrer de Roger de Flor, 272, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Roger de Flor, 185, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Roger de Flor, 225, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Provença, 378, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Provença, 378, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "stalking", user: user4, location: "Carrer de Girona, 175, 08037 Barcelonas", date: '2021-09-16', time: '2000-01-01 12:54:00')

Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 324, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 324, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 346, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 346, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 395, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 395, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 374, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer del Rosselló, 374, 08025 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')

Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 446, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 454, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 485, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 476, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 504, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 446, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 454, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 485, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 476, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
Incident.create!(crime: "Harrassment", user: user4, location: "Carrer de Còrsega, 504, 08037 Barcelona", date: '2021-09-16', time: '2000-01-01 12:54:00')
