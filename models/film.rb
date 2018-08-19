class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @title = info['title']
    @price = info['price'].to_i
  end

  def save
    sql = "INSERT INTO films
    (title, price)
    VALUES
    ($1, $2)
    RETURNING *"
    values = [@title, @price]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def update()
    sql = "UPDATE films
    SET title = $1, genre = $2
    WHERE id = $3 "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM films
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Customer.map_items(result)
  end

  def number_of_customers
    return customers.count
  end

  def screenings()
    sql = "SELECT * FROM screenings
    WHERE film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return Screening.map_items(result)
  end

  def most_popular_time
    screening = screenings.max_by { |screening| screening.seats - screening.seats_left }
    return "Film: #{@title} Screening time: #{screening.screening_time} Tickets sold: #{screening.seats - screening.seats_left}"

  end

  def self.map_items(film_data)
    film_data.map { |film| Film.new(film)  }
  end

  def self.all
    sql = "SELECT * FROM films"
    result = SqlRunner.run(sql)
    return self.map_items(result)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    if result.count > 0
      film.map_items(result)
    else
      return nil
    end
  end

end
