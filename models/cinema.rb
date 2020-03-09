require_relative("./customer.rb")
require_relative("./film.rb")
require('pry')

class Cinema

  attr_accessor :name, :customers, :films, :tickets, :till

  def initialize(name,customers=[],films=[],tickets=[],till=0.0)
    @name = name
    @customers = customers
    @films = films
    @tickets = tickets
    @till = till
  end

  def sell_ticket(customer_id,screening_id)
    # binding.pry
    customer = Customer.get_by_id(customer_id)
    screening = Screening.get_by_id(screening_id)
    film = Film.get_by_id(screening.film_id)
    if customer.funds < film.price
      p "Sorry, not enough money!"
      return nil
    end
    if 0 == screening.seats
      p "Sorry, not enough seats!"
      return nil
    end

    customer.funds = (BigDecimal(customer.funds.to_s) - BigDecimal(film.price.to_s)).to_f
    customer.update
    screening.seats -= 1
    screening.update
    ticket = Ticket.new({"film_id"=>film.id,
                         "customer_id"=>customer.id,
                         "screening_id"=>screening.id})

      #
      # @id          = ticket['id'].to_i  if ticket['id']
      # @film_id     = ticket['film_id'].to_i
      # @customer_id = ticket['customer_id'].to_i
      # @screening_id= ticket['screening_id'].to_i
    ticket.save
    @till += film.price

  end

end
