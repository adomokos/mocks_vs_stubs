require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'order'

describe Order do
  it "fills the order with enough item at the warehouse location" do
    order = Order.new(:Cleveland, 50)
    warehouse = mock(:warehouse)

    # Note how warehouse behaviour is mocked with rspec mock
    warehouse.should_receive(:quantity_at).with(:Cleveland).and_return(50)
    warehouse.should_receive(:set_quantity_at).with(:Cleveland, 0)

    order.fill(warehouse)
    order.should be_filled
  end

  it "does not fill the order with not enough items at the warehouse location" do
    order = Order.new(:Cleveland, 51)
    warehouse = mock(:warehouse)

    # Note how warehouse behaviour is mockec with rspec mock
    warehouse.should_receive(:quantity_at).with(:Cleveland).and_return(50)

    order.fill(warehouse)
    order.should_not be_filled
  end
end
