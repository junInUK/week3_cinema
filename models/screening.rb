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



end
