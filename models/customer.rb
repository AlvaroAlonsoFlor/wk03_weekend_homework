require_relative('../db/sql_runner.rb')
require_relative('ticket.rb')
require_relative('screening.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds, :tickets

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @name = info['name']
    @funds = info['funds'].to_i
    @tickets = info['tickets'].to_i
  end

  def save
    sql = "INSERT INTO customers
    (name, funds, tickets)
    VALUES
    ($1, $2, $3)
    RETURNING *"
    values = [@name, @funds, @tickets]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def update()
    sql = "UPDATE customers
    SET name = $1, funds = $2, tickets = $4
    WHERE id = $3 "
    values = [@name, @funds, @id, @tickets]
    SqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM customers
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Film.map_items(result)
  end

  def buy_ticket(film, screening)

    pay(film.price)
    @tickets += 1
    update
    ticket = Ticket.new({
      'customer_id' => @id,
      'film_id' => film.id,
      'screening_id' => screening.id
      })
    ticket.save

  end


  def pay(amount)
    return if can_pay?(amount) == false
    @funds -= amount
  end

  def can_pay?(amount)
    return true if @funds >= amount
    return false
  end

  def self.map_items(customer_data)
    customer_data.map { |customer| Customer.new(customer)  }
  end

  def self.all
    sql = "SELECT * FROM customers"
    result = SqlRunner.run(sql)
    return self.map_items(result)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM customers
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    if result.count > 0
      Customer.map_items(result)
    else
      return nil
    end
  end

end
