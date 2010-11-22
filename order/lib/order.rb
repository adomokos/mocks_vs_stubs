class Order
  def initialize(location, quantity)
    @location, @quantity = location, quantity
  end

  def fill(warehouse)
    quantity_at_location = warehouse.quantity_at(@location)
    if (@quantity <= quantity_at_location)
      warehouse.set_quantity_at(@location, quantity_at_location - @quantity)
      @filled = true and return
    end

    @filled = false
  end

  def filled?; @filled; end
end
