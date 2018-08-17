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

film2 = Film.new ({
  'title' => 'Harry Potter and the Half Blood Prince',
  'price' => 5
  })


customer1.save
film1.save
film2.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
  })

ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film2.id
  })

ticket1.save
ticket2.save

binding.pry
nil
