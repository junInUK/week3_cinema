require('minitest/autorun')
require('minitest/reporters')
require('pry-byebug')
MiniTest::Reporters.use!
MiniTest::Reporters::SpecReporter.new

require_relative('../models/customer.rb')

class TestCustomer<MiniTest::Test

  Customer.delete_all()

  def setup
    @customer1 = Customer.new({"name"=>"alex","funds"=>10})
    @customer1.save()
  end

  def test_save_customer()
    assert_equal(1,Customer.all.count())
  end

  def test_get_customer_by_id()
    assert_equal(@customer1,Customer.get_customer_by_id(@customer1.id))
  end

  # def test_customer_all()
  #   # @customer1.save()
  #   assert_equal(1,Customer.all().count())
  # end
  #
  # def test_customer_update()
  #   @customer1.funds = 20
  #   @customer1.update()
  #   assert_equal(20,Customer.get_customer_by_id(@customer1.id).funds)
  # end




end
