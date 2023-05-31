require './lib/ship'

class Cell 
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty? 
    !@ship
  end

  def place_ship(new_ship)
    @ship = new_ship
  end

  def fired_upon? 
    @fired_upon
  end

  def fire_upon 
    @fired_upon = true
    @ship.hit if @ship != nil
  end

  def render(show_ships = false)
    return "S" if !@fired_upon && show_ships && @ship
    return "." if !@fired_upon
    return "M" if !@ship 
    return "X" if @ship.sunk?
    "H"
  end
end