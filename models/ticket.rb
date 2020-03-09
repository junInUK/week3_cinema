class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize( ticket )
    @id          = ticket['id'].to_i  if ticket['id']
    # @film_id     = ticket['film_id'].to_i
    @customer_id = ticket['customer_id'].to_i
    @screening_id= ticket['screening_id'].to_i
  end

  def save
    sql = "INSERT INTO tickets (customer_id,screening_id)
     VALUES ($1,$2) RETURNING id"
    values = [@customer_id,@screening_id]
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
    sql = "UPDATE tickets SET customer_id = $1,
    screening_id = $2 where id = $3"
    values = [@customer_id,@screening_id,@id]
    SqlRunner.run(sql,values)
  end

  def Ticket.delete_by_id(id)
    sql = "delete from tickets where id = $1"
    value = [id]
    result = SqlRunner.run(sql,value)
  end

end
