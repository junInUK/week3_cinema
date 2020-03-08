class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( film )
    @id    = film['id'].to_i if film['id']
    @title = film['title']
    @price = film['price'].to_f
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ($1,$2) RETURNING id"
    values = [@title,@price]
    film = SqlRunner.run(sql,values).first
    @id = film['id'].to_i
  end

  def Film.delete_all
    sql = "DELETE from films"
    SqlRunner.run(sql)
  end

  def Film.all
    sql = "SELECT * FROM films"
    results = SqlRunner.run(sql)
    films = results.map{|film| Film.new(film)}
    return films
  end

  def update
    sql = "UPDATE films SET title = $1,price = $2 where id = $3"
    values = [@title,@price,@id]
    SqlRunner.run(sql,values)
  end

  # Show all the films a customer has booked to see
  def Film.get_films_by_customer_id(id)
    sql = "select films.* from films inner join tickets
    on films.id = tickets.film_id where tickets.customer_id = $1"
    value = [id]
    results = SqlRunner.run(sql,value)
    films = results.map{|film| Film.new(film)}
    return films
  end

  def Film.get_by_id(id)
    sql = "SELECT * FROM films where id=$1"
    value = [id]
    result = SqlRunner.run(sql,value).first
    film_find = Film.new(result)
    return film_find
  end

  def Film.delete_by_id(id)
    sql = "delete from films where id = $1"
    value = [id]
    result = SqlRunner.run(sql,value)
  end

end
