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

  def render(show_ships = false)
    if @fired_upon == false   #if not shot, should only return "S" or "."
      if show_ships == true && @ship != nil
        "S"
      else
        "."
      end
    else  #if is shot should return "M" "X" or "H"
      if @ship == nil 
       "M"
      else 
        if @ship.sunk? == true
          "X"
        else
          "H"
        end
      end
    end
  end
end