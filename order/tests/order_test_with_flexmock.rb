require File.expand_path(File.dirname(__FILE__) + '/../lib/order')
require 'test/unit'
require 'flexmock/test_unit'

class TestOrder < Test::Unit::TestCase
  def test_fills_order_with_enough_item_at_location
    order = Order.new(:Cleveland, 50)
    warehouse = flexmock('warehouse')

    warehouse.should_receive(:quantity_at).with(:Cleveland).and_return(50)
    warehouse.should_receive(:set_quantity_at).with(:Cleveland, 0)
    
    order.fill(warehouse)
    assert order.filled?
  end

  def test_does_not_fill_order_with_not_enough_item_at_location
    order = Order.new(:Cleveland, 51)
    warehouse = flexmock('warehouse')

    # Note how warehouse behaviour is mockec with rspec mock
    warehouse.should_receive(:quantity_at).with(:Cleveland).and_return(50)

    order.fill(warehouse)
    assert order.filled? == false
  end
end
