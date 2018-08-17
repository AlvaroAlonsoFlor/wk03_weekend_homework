require('minitest/autorun')
require('minitest/rg')
require_relative('../models/customer')

class TestCustomer < MiniTest::Test
  def setup
    @customer1 = Customer.new({
      'name' => 'Alvaro',
      'funds' => 30
      })
  end

  def test_pay
    assert_equal(25, @customer1.pay(5))
  end

  def test_pay_no_money
    assert_equal(nil, @customer1.pay(40))
  end

  def test_can_pay?
    assert_equal(true, @customer1.can_pay?(5))
  end
end
