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

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon? 
    @fired_upon
  end

  def fire_upon 
    @fired_upon = true
    @ship.hit if @ship != nil
  end

  def render 
    if @fired_upon == false
      "."
    else 
      "M"
    end
  end
end