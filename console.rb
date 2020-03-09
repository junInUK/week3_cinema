require_relative("models/customer.rb")
require_relative("models/film.rb")
require_relative("models/ticket.rb")
require_relative("models/screening.rb")
require_relative("models/cinema.rb")
require("pry")

cinema_star = Cinema.new("cinema star")

Screening.delete_all
Ticket.delete_all
Film.delete_all
Customer.delete_all

customer1 = Customer.new({"name"=>"alex","funds"=>30.0})
customer1.save()
customer2 = Customer.new({"name"=>"bob","funds"=>40.0})
customer2.save()
customer3 = Customer.new({"name"=>"sam","funds"=>50.0})
customer3.save()

film1 = Film.new({"title"=>"007 sky fall","price"=>5.4})
film1.save()
film2 = Film.new({"title"=>"titanic","price"=>3.8})
film2.save()
film3 = Film.new({"title"=>"kongfu panda","price"=>2.9})
film3.save()

screening_007_1 = Screening.new("name" => "Edinburgh","show_time"=>"2020-04-04 14:00",
  "film_id"=>film1.id, "seats"=>2)
screening_007_1.save()
screening_titanic_1 = Screening.new("name" => "Glasgow","show_time"=>"2020-05-05 15:00",
  "film_id"=>film2.id,"seats"=>2)
screening_titanic_1.save()
screening_panda_1 = Screening.new("name" => "Aberdeen","show_time"=>"2020-06-06 16:00",
  "film_id"=>film3.id,"seats"=>2)
screening_panda_1.save()
screening_panda_2 = Screening.new("name" => "Edinburgh","show_time"=>"2020-06-06 20:00",
 "film_id"=>film3.id,"seats"=>5)
 screening_panda_2.save()


cinema_star.sell_ticket(customer1.id,screening_007_1.id)

cinema_star.sell_ticket(customer1.id,screening_titanic_1.id)
cinema_star.sell_ticket(customer2.id,screening_titanic_1.id)

cinema_star.sell_ticket(customer1.id,screening_panda_1.id)
cinema_star.sell_ticket(customer2.id,screening_panda_1.id)
cinema_star.sell_ticket(customer3.id,screening_panda_1.id)

cinema_star.sell_ticket(customer1.id,screening_panda_2.id)
cinema_star.sell_ticket(customer2.id,screening_panda_2.id)
cinema_star.sell_ticket(customer3.id,screening_panda_2.id)

binding.pry
nil
