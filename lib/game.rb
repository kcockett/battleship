require './lib/cell'
require './lib/ship'
require './lib/board'

class Game

  attr_reader :player_cruiser, 
              :player_submarine, 
              :computer_cruiser, 
              :computer_submarine,
              :computer_board,
              :player_board
  def initialize
    @player_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]
    @player_board = Board.new
    @computer_board = Board.new
  end

  def start_ship_placement
    computer_ship_setup
    player_ship_setup
    take_turns
  end
  
  def computer_ship_setup
    @computer_ships.each do |ship| # Iterate through all ships
      loop do # Pick ship placement
        if rand(1..2) == 1 # Pick horizontal orientation
          row_pick = rand(65..68).chr
          column_pick = rand(1..(5 - ship.length)) #Pick valid columns for ship size
          coordinates = []
          (ship.length).times do
            coordinate = "#{row_pick}#{column_pick}"
            coordinates << coordinate
            column_pick = column_pick.succ
          end
        else # Pick vertical orientation
          row_pick = rand(65..(69-ship.length)).chr #Pick valid row for ship size
          column_pick = rand(1..4)
          coordinates = []
          (ship.length).times do
            coordinate = "#{row_pick}#{column_pick}"
            coordinates << coordinate
            row_pick = row_pick.succ
          end
        end
        # Validate placement or randomize again
        if @computer_board.valid_placement?(ship, coordinates) == true
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
      puts @player_board.render(true)
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
      puts @computer_board.render
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)
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
      
      if @computer_board.cells[@player_pick].empty? # Check player shot
        player_result = "miss"
      else
        player_result = "hit"
      end

      if @player_board.cells[@computer_pick].empty? # Check computer shot
        computer_result = "miss"
      else
        computer_result = "hit"
      end

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