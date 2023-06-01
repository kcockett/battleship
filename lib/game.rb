require './lib/cell'
require './lib/ship'
require './lib/board'

class Game

  attr_reader :computer_board,
              :player_board,
              :board_column_size,
              :board_row_size
  def initialize
    @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @board_column_size = 0
    @board_row_size = 0
  end

  def start_game
    choose_board_size
    computer_ship_setup
    player_ship_setup
    take_turns
  end

  def choose_board_size
    puts " "
    puts "Please choose your board size"
    @board_column_size = get_valid_board_size("columns")
    puts " "
    @board_row_size = get_valid_board_size("rows")
    cells_hash = create_cells
    @player_board = Board.new(cells_hash)
    @computer_board = Board.new(cells_hash)
  end
  
  def get_valid_board_size(direction)
    loop do
      puts "How many #{direction} would you like? (up to 26)"
      size = gets.chomp.to_i
      return size if size.between?(1, 26)
      puts "Please enter a valid board size (1 - 26)"
    end
  end
  
  def create_cells
    hash_of_cells = Hash.new
    column = "1"
    row = "A"
    @board_row_size.times do
      @board_column_size.times do
        coordinate = "#{row}#{column}"
        hash_of_cells[coordinate] = Cell.new(coordinate)
        column = column.succ
      end
      column = 1
      row = row.succ
    end
    hash_of_cells
  end
  
  def computer_ship_setup
    @computer_ships.each do |ship| # Iterate through all ships
      loop do # Pick ship placement
        if rand(1..2) == 1 # Pick horizontal orientation
          row_pick = rand(65..(64 + @board_row_size)).chr
          column_pick = rand(1..((@board_column_size + 1) - ship.length)) #Pick valid columns for ship size
          coordinates = []
          (ship.length).times do
            coordinate = "#{row_pick}#{column_pick}"
            coordinates << coordinate
            column_pick = column_pick.succ
          end
        else # Pick vertical orientation
          row_pick = rand(65..((64 + @board_row_size) - ship.length)).chr #Pick valid row for ship size
          column_pick = rand(1..4)
          coordinates = []
          (ship.length).times do
            coordinate = "#{row_pick}#{column_pick}"
            coordinates << coordinate
            row_pick = row_pick.succ
          end
        end
        # Validate placement or randomize again
        if @computer_board.valid_placement?(ship, coordinates)
          @computer_board.place(ship, coordinates)
          break
        end
      end
    end
  end
  
  def player_ship_setup
    @player_ships.each do |ship| # Iterate through all ships
      loop do
        puts "Enter the squares for the #{ship.name} (#{ship.length} spaces):"
        player_picks = gets.upcase.chomp.split(" ")
        if @player_board.valid_coordinate?(player_picks) && @player_board.valid_placement?(ship, player_picks)
          @player_board.place(ship, player_picks)
          break
        end
        puts "Those are invalid coordinates.  Please try again"
      end
      puts @player_board.render(true, @board_column_size, board_row_size)
    end
  end
  
  def take_turns 
    loop do
      puts " "
      puts " "
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~NEW~TURN~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts " "
      #display boards
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(false, @board_column_size, @board_row_size)
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true, @board_column_size, @board_row_size)
      puts " "

      # Player Shot
      puts "Enter the coordinate for your shot:"
      loop do 
        @player_pick = gets.chomp.upcase 
        if @player_board.valid_coordinate?(@player_pick) # Validicate the entry
          break if !@computer_board.cells[@player_pick].fired_upon? # Check for duplicate shot
          puts "You've already shot there before!"
        end
        puts "Please enter a valid coordinate:"
      end

      # Computer Shot
      loop do 
        row_pick = rand(65..68).chr
        column_pick = rand(1..4)
        @computer_pick = "#{row_pick}#{column_pick}"
        break if !@player_board.cells[@computer_pick].fired_upon?
      end

      # Results
      @computer_board.cells[@player_pick].fire_upon # Record hits
      @player_board.cells[@computer_pick].fire_upon
      
      player_result = @computer_board.cells[@player_pick].empty? ? "miss" : "hit" # Conditional ternary operator
      computer_result = @player_board.cells[@computer_pick].empty? ? "miss" : "hit"

      puts "Your shot on #{@player_pick} was a #{player_result}." # Player shot response
      if !@computer_board.cells[@player_pick].empty?
        puts "You've hit my #{@computer_board.cells[@player_pick].ship.name}"
        puts "...and you've sunk it!" if @computer_board.cells[@player_pick].ship.sunk?
      end

      puts "My shot on #{@computer_pick} was a #{computer_result}."
      if !@player_board.cells[@computer_pick].empty?
        puts "I've hit your #{@player_board.cells[@computer_pick].ship.name}"
        puts "...and I've sunk it!" if @player_board.cells[@computer_pick].ship.sunk?
      end
      break if winner? # Stop the game if there is a winner
    end # Repeat everything if there is NO winner
  end

  def winner?
    if @player_ships.all? { |ship| ship.sunk?} && @computer_ships.all? { |ship| ship.sunk?} # This is a tie
      puts "---------------------------------------------"
      puts "|    What are the chances?  It's a TIE!     |"
      puts "---------------------------------------------"
      puts " "
      true
    elsif @player_ships.all? { |ship| ship.sunk?} # Computer wins
      puts "---------------------------------------------"
      puts "| Haha, better luck next time HUMAN! I win! |"
      puts "---------------------------------------------"
      puts " "
      true
    elsif @computer_ships.all? { |ship| ship.sunk?} # Player wins
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts "|   Congratulations, you win!   |"
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      puts " "
      true
    else
      false
    end
  end
end