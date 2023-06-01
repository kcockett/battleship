require './lib/cell'
require './lib/game'

class Board
  attr_reader :cells

  def initialize(cells = nil)
    @cells = cells
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

  def render(show_ships = false, columns = 1, rows = 1)
    output = "  " # Display header row
    (1..rows).each do |column_label|
      output << "#{column_label} "
    end
    output << "\n"
    row_label = "A"
    #rows.times do
      @cells.values.each_slice(columns) do |cell| # Iterate through each Row
        output << "#{row_label} "
        cell.each do |value|
          output << "#{value.render(show_ships)} "
        end
        output << "\n" # Start a new row
        row_label = row_label.succ
      end
    #end
    output
  end
end