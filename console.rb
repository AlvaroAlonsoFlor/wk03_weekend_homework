require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

Customer.delete_all

customer1 = Customer.new({
  'name' => 'Alvaro',
  'funds' => 30
  })

customer1.save

binding.pry
nil
