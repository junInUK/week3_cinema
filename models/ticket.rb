class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize( ticket )
    @id          = ticket['id'].to_i  if ticket['id']
    @film_id     = ticket['film_id'].to_i
    @customer_id = ticket['customer_id'].to_i
    @screening_id= ticket['screening_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (film_id,customer_id,screening_id)
     VALUES ($1,$2,$3) RETURNING id"
    values = [@film_id,@customer_id,@screening_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def Ticket.delete_all
    sql = "DELETE from tickets"
    SqlRunner.run(sql)
  end

  def Ticket.all
    sql = "SELECT * FROM tickets"
    results = SqlRunner.run(sql)
    tickets = results.map{|ticket| Ticket.new(ticket)}
    return tickets
  end

  def update
    sql = "UPDATE tickets SET film_id = $1,customer_id = $2,
    screening_id = $3 where id = $4"
    values = [@film_id,@customer_id,@screening_id,@id]
    SqlRunner.run(sql,values)
  end

  def Ticket.delete_by_id(id)
    sql = "delete from tickets where id = $1"
    value = [id]
    result = SqlRunner.run(sql,value)
  end

end
