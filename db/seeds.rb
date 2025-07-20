# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding departments... Started!"

departments = [
  { name: 'Computer Science & Engineering' },
  { name: 'Electronics & Communication Engineering' },
  { name: 'Mechanical Engineering' },
  { name: 'Civil Engineering' },
  { name: 'Electrical & Electronics Engineering' }
]

departments.each do |dept|
  Department.create!(dept)
end
puts "Seeding departments... Completed!"

puts "Seeding subjects... In-progress"

cse = Department.find_by(name: 'Computer Science & Engineering')
ece = Department.find_by(name: 'Electronics & Communication Engineering')
mech = Department.find_by(name: 'Mechanical Engineering')
civil = Department.find_by(name: 'Civil Engineering')
eee = Department.find_by(name: 'Electrical & Electronics Engineering')

Subject.create!([
  { name: 'Data Structures', department: cse },
  { name: 'Operating Systems', department: cse },
  { name: 'Database Management Systems', department: cse },
  { name: 'Digital Electronics', department: ece },
  { name: 'Signals & Systems', department: ece },
  { name: 'Thermodynamics', department: mech },
  { name: 'Fluid Mechanics', department: mech },
  { name: 'Structural Analysis', department: civil },
  { name: 'Surveying', department: civil },
  { name: 'Power Systems', department: eee },
  { name: 'Control Systems', department: eee }
])


puts "Seeding subjects... Completed!"
