require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'order'

describe Order do
  before(:each) do
    @warehouse = stub('warehouse_stub', {:quantity_at => 50, :set_quantity_at => true})
  end

  it "fills the order with enough items at the warehouse location" do
    order = Order.new(:Cleveland, 50)

    order.fill(@warehouse)
    order.should be_filled
  end

  it "does not fill the order with not enough items at the warehouse location" do
    order = Order.new(:Cleveland, 51)

    order.fill(@warehouse)
    order.should_not be_filled
  end
end
