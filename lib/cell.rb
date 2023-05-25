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

  def 

end