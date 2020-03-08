require('pry')
require_relative("../db/sql_runner.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(customer)
    @id = customer['id'].to_i if customer['id']
    @name = customer['name']
    @funds = customer['funds'].to_f
  end

  def save
    sql = "INSERT INTO customers (name,funds) VALUES ($1,$2) RETURNING id"
    values = [@name,@funds]
    customer = SqlRunner.run(sql,values).first
        # binding.pry
    @id = customer['id'].to_i

  end

  def Customer.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def Customer.all
    sql = "SELECT * FROM customers"
    results = SqlRunner.run(sql)
    customers = results.map{|customer| Customer.new(customer)}
    # binding.pry
    return customers
  end

  def update
    # update customers set name = 'sam',funds = 50 where id = 32 returning id
    sql = "UPDATE customers set name=$1,funds=$2 where id=$3 RETURNING id"
    values = [@name,@funds,@id]
    customer = SqlRunner.run(sql,values).first

    # binding.pry
  end

  def Customer.get_by_id(id)
    sql = "SELECT * FROM customers where id=$1"
    value = [id]
    # binding.pry
    result = SqlRunner.run(sql,value).first
    customer_find = Customer.new(result)
    # binding.pry
    return customer_find
  end

#see all the customers are coming to see one film.
  def Customer.get_customers_by_film_id(id)
    sql = "select customers.* from customers inner join tickets
    on customers.id = tickets.customer_id where tickets.film_id = $1"
    value = [id]
    results = SqlRunner.run(sql,value)
    customers = results.map{|customer| Customer.new(customer)}
    return customers
  end

#get all the tickets bought by a specific customer
  def get_tickets_by_id
    sql = "select tickets.* from tickets inner join customers
    on customers.id = tickets.customer_id where customers.id =$1"
    value = [@id]
    results = SqlRunner.run(sql,value)
    tickets = results.map{|ticket| Ticket.new(ticket)}
    return tickets  
  end

  def Customer.delete_by_id(id)
    sql = "delete from customers where id=$1"
    value = [id]
    result = SqlRunner.run(sql,value)
  end

  # def get_films
  #   sql = "SELECT * FROM customers INNER JOIN "
  # end

end
