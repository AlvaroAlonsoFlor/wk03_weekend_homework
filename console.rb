require('pry-byebug')
require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')
require_relative('models/screening')

Customer.delete_all
Film.delete_all
Ticket.delete_all

customer1 = Customer.new({
  'name' => 'Alvaro',
  'funds' => 30,
  'tickets' => 0
  })

customer2 = Customer.new({
  'name' => 'Alison',
  'funds' => 50,
  'tickets' => 0
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
customer2.save
film1.save
film2.save

screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '1600',
  'seats' => 10
  })
screening2 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '2100',
  'seats' => 20
  })

screening1.save
screening2.save

customer1.buy_ticket(film1, screening1)
customer2.buy_ticket(film1, screening2)


binding.pry
nil
