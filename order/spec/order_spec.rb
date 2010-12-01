require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'order'

class Warehouse
  attr_reader :locations

  def add(location, quantity)
    @locations ||= Hash.new
    @locations[location] = quantity
  end

  def quantity_at(location)
    return @locations[location]
  end

  def set_quantity_at(location, quantity)
    @locations[location] = quantity
  end
end

describe Order do
  before(:each) do
    @warehouse = Warehouse.new
    @warehouse.add(:Cleveland, 50)
    @warehouse.add(:Akron, 25)
  end

  it "fills the order with enough items in warehouse" do
    order = Order.new(:Cleveland, 50)
    order.fill(@warehouse)

    order.should be_filled
    @warehouse.quantity_at(:Cleveland).should == 0
  end

  it "does not fill the order with not enough items" do
    order = Order.new(:Cleveland, 51)
    order.fill(@warehouse)

    order.should_not be_filled
    @warehouse.quantity_at(:Cleveland).should == 50
  end
end
