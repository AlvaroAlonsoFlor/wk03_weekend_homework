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

customer1.buy_ticket(film1)
customer2.buy_ticket(film1)

screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '16:00',
  'seats' => 10
  })
screening2 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '21:00',
  'seats' => 20
  })

screening1.save
screening2.save

# ticket1 = Ticket.new({
#   'customer_id' => customer1.id,
#   'film_id' => film1.id
#   })
#
# ticket2 = Ticket.new({
#   'customer_id' => customer1.id,
#   'film_id' => film2.id
#   })
#
# ticket3 = Ticket.new({
#   'customer_id' => customer2.id,
#   'film_id' => film1.id
#   })
#
#
# ticket1.save
# ticket2.save
# ticket3.save

binding.pry
nil
