require_relative("../db/sql_runner.rb")

class Screening

  attr_reader :id
  attr_accessor :name, :show_time, :film_id, :seats

  def initialize( screening )
    @id        = screening['id'].to_i if screening['id']
    @name      = screening['name']
    @show_time = screening['show_time']
    @film_id   = screening['film_id'].to_i
    @seats     = screening['seats'].to_i
  end

  def save
    sql = "INSERT INTO screenings (name,show_time,film_id,seats)
    VALUES ($1,$2,$3,$4) RETURNING id"
    values = [@name,@show_time,@film_id,@seats]
    screening = SqlRunner.run(sql,values).first
    @id = screening['id'].to_i
  end

  def update
    sql = "UPDATE screenings SET name = $1, show_time = $2,
    film_id = $3, seats = $4 WHERE id = $5"
    values = [@name,@show_time,@film_id,@seats,@id]
    SqlRunner.run(sql,values)
  end

  def Screening.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  def Screening.delete_by_id(id)
    sql = "DELETE FROM screenings WHERE id = $1"
    value = [id]
    SqlRunner.run(sql,value)
  end

  def Screening.all
    sql = "SELECT * FROM screenings"
    results = SqlRunner.run(sql)
    screenings = results.map{|screening| Screening.new(screening)}
    return screenings
  end

  def Screening.get_by_id(id)
    sql = "SELECT * FROM screenings WHERE id = $1"
    value = [id]
    result = SqlRunner.run(sql,value).first
    screening = Screening.new(result)
    return screening
  end

  def Screening.get_most_popular_screening_by_film_id(film_id)
    # binding.pry
    sql = "SELECT tickets.screening_id,count(*) as count from tickets
    inner join screenings on tickets.screening_id = screenings.id
    where screenings.film_id = $1
    group by tickets.screening_id
    order by count desc"
    value = [film_id]
    result = SqlRunner.run(sql,value)
    if result != nil
      most_popular_screening_id = result.first["screening_id"].to_i
      return Screening.get_by_id(most_popular_screening_id)
    end
    return nil
  end

end
