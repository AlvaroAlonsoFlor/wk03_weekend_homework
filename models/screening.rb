class Screening

  attr_reader :id
  attr_accessor :film_id, :screening_time

  def initialize(info)
    @id = info['id'].to_i if info['id']
    @film_id = info['film_id'].to_i
    @screening_time = info['screening_time'].to_i
    @seats = info['seats'].to_i
  end

  def save
    sql = "INSERT INTO screenings
    (film_id, screening_time, seats)
    VALUES
    ($1, $2, $3)
    RETURNING *"
    values = [@film_id, @screening_time, @seats]
    result = SqlRunner.run(sql, values)
    @id = result.first['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
    SET film_id = $1, screening_time = $2, seats = $4
    WHERE id = $3 "
    values = [@film_id, @screening_time, @id, @seats]
    SqlRunner.run(sql, values)

  end

  def delete()
    sql = "DELETE FROM screenings
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.map_items(screening_data)
    screening_data.map { |screening| Screening.new(screening)  }
  end

  def self.all
    sql = "SELECT * FROM screenings"
    result = SqlRunner.run(sql)
    return self.map_items(result)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM screenings
    WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    if result.count > 0
      screening.map_items(result)
    else
      return nil
    end
  end

end
