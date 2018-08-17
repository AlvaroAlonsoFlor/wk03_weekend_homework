class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @customer_id = info['customer_id'].to_i
    @film_id = info['film_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets
    (customer_id, film_id)
    VALUES
    ($1, $2)
    RETURNING *"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
    SET customer_id = $1, genre = $2
    WHERE id = $3 "
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM tickets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(ticket_data)
    ticket_data.map { |ticket| Ticket.new(ticket)  }
  end

  def self.all
    sql = "SELECT * FROM tickets"
    result = SqlRunner.run(sql)
    return self.map_items(result)
  end

  def self.delete_all
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    if result.count > 0
      ticket.map_items(result)
    else
      return nil
    end
  end

end
