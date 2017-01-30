# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
unless Rails.env.test?
   User.create({:email => "user@mlab.com.br", :password => "mlab@2017", :password_confirmation => "mlab@2017", :name => "User Test"}) unless User.exists?(:email => "user@mlab.com.br")
   User.create({:email => "renan.azevedo.carvalho@gmail.com", :password => "renan123", :password_confirmation => "renan123", :name => "Renan Carvalho", provider: "email"}) unless User.exists?(:email => "renan.azevedo.carvalho@gmail.com")
  
end
