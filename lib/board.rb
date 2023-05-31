require './lib/cell'
#require './lib/ship'

class Board
  attr_reader :cells

  def initialize
    @cells = {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4"),
     }
  end

  def valid_coordinate?(coordinate)
    if coordinate.is_a?(String)
      @cells.has_key?(coordinate)
    elsif coordinate.is_a?(Array)
      #Iterate through the array
      coordinate.all? do |coordinate|
        @cells.has_key?(coordinate)
      end
    end
  end

  def valid_placement?(ship,coordinates)
    
    ship.length == coordinates.length && 
    !occupied?(coordinates) &&
    consecutive_placement?(coordinates)
  end

  def consecutive_placement?(coordinates)
    letters = []
    numbers = []
    coordinates.each do |coordinate| 
      letters << coordinate.chr 
      numbers << coordinate.chars.last
    end
    if letters.uniq.size == 1 
      #confirms horizontal
      numbers.each_cons(2).all? {|a,b| b == a.succ}
    elsif numbers.uniq.size == 1 
      #confirms vertical
      letters.each_cons(2).all? {|a,b| b == a.succ}
    else
      false #everything else invalid 
    end
  end

  def occupied?(coordinates)
    coordinates.any? do |coordinate|
      !@cells[coordinate].empty?
    end
  end

  def place(ship,coordinates)
    if valid_placement?(ship,coordinates)
      #place ship into cells
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    end
  end

  def render(show_ships = false)
    output = "  1 2 3 4 \n"
    row = "A"
  @cells.values.each_slice(4) do |cell|
    output << row + " "
    cell.each do |value|
      output << value.render(show_ships) + " "
    end
    output << "\n"
    row = row.succ
  end
    # output = "  1 2 3 4 \n" +
    # "A . . . . \n" +
    # "B . . . . \n" +
    # "C . . . . \n" +
    # "D . . . . \n"
    output
  end
end