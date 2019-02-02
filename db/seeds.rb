# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create admin user
User.create!(email: 'admin@minijira.com', password: 'password', name: 'Super Admin', admin: true)

# Create Projects
['ABC project', 'HealthCare Project'].each {
	|name| Project.create(name: name)
}

# Create Developers
[
	{email: 'dev1@minijira.com', password: 'password', name: 'Developer 1'},
	{email: 'dev2@minijira.com', password: 'password', name: 'Developer 2'},
	{email: 'dev3@minijira.com', password: 'password', name: 'Developer 3'},
	{email: 'dev4@minijira.com', password: 'password', name: 'Developer 4'}
].each do |user|
	User.create!(user)
end

# Add users to projects
Project.where(name: 'ABC project').first.users << User.where(name: ['Developer 1','Developer 2'])
Project.where(name: 'HealthCare Project').first.users << User.where(name: ['Developer 3','Developer 4'])


# Create Todos
['Todo1','Todo2','Todo3','Todo4','Todo5'].each do |name|
	Todo.create(name: name, project: Project.first)
end

['Todo6','Todo7','Todo8','Todo9','Todo10'].each do |name|
	Todo.create(name: name, project: Project.second)
end

# Mark one task in progress
Todo.where(name: ['Todo1','Todo8']).first.update_attributes(status: 1)
Todo.where(name: ['Todo5','Todo10']).first.update_attributes(status: 2)

# Assign todo to a user
User.where(email: 'dev1@minijira.com').first.todos << Todo.where(name: ['Todo1','Todo5','Todo4'])
User.where(email: 'dev3@minijira.com').first.todos << Todo.where(name: ['Todo3'])
User.where(email: 'dev3@minijira.com').first.todos << Todo.where(name: ['Todo8'])
User.where(email: 'dev4@minijira.com').first.todos << Todo.where(name: ['Todo10'])