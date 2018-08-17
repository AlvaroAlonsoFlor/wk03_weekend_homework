require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Customer.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => 'Alvaro',
  'funds' => 30
  })

film1 = Film.new({
  'title' => 'The Rock',
  'price' => 5
  })


customer1.save
film1.save

binding.pry
nil
