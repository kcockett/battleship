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
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @player_board = Board.new
    @computer_board = Board.new
  end

  def start_ship_placement
    computer_ship_setup
    player_ship_setup
    take_turns
  end
  
  def computer_ship_setup
    
    loop do # Pick Cruiser placement
      if rand(1..2) == 1 # pick horz/vertical
        #HORIZONTAL
        row_pick = rand(65..68).chr
        column_pick = rand(1..(5-@computer_cruiser.length))
        coordinates = []
        (@computer_cruiser.length).times do
          coordinate = "#{row_pick}#{column_pick}"
          coordinates << coordinate
          column_pick = column_pick.succ
        end
      else
        #VERTICAL
        row_pick = rand(65..(69-@computer_cruiser.length)).chr
        column_pick = rand(1..4)
        coordinates = []
        (@computer_cruiser.length).times do
          coordinate = "#{row_pick}#{column_pick}"
          coordinates << coordinate
          row_pick = row_pick.succ
        end
      end
      # Validate placement or randomize again
      if @computer_board.valid_placement?(@computer_cruiser, coordinates) == true
        @computer_board.place(@computer_cruiser, coordinates)
        break
      end
    end

    loop do # Pick Submarine placement
      if rand(1..2) == 1
        #HORIZONTAL
        row_pick = rand(65..68).chr
        column_pick = rand(1..(5-@computer_submarine.length))
        coordinates = []
        (@computer_submarine.length).times do
          coordinate = "#{row_pick}#{column_pick}"
          coordinates << coordinate
          column_pick = column_pick.succ
        end
      else
        #VERTICAL
        row_pick = rand(65..(69-@computer_submarine.length)).chr
        column_pick = rand(1..4)
        coordinates = []
        (@computer_submarine.length).times do
          coordinate = "#{row_pick}#{column_pick}"
          coordinates << coordinate
          row_pick = row_pick.succ
        end
      end
      # Validate placement or randomize again
      if @computer_board.valid_placement?(@computer_submarine, coordinates) == true
        @computer_board.place(@computer_submarine, coordinates)
        break
      end
    end

  end
  
  def player_ship_setup
    # place ships on the board
    # pick a ship - Cruiser
    # input ship and coordinates
    loop do
      puts "Enter the squares for the Cruiser (3 spaces):"
      player_picks = gets.upcase.chomp.split(" ")
      if @player_board.valid_coordinate?(player_picks) && @player_board.valid_placement?(@player_cruiser, player_picks)
        @player_board.place(@player_cruiser, player_picks)
        break
      end
      puts "Those are invalid coordinates.  Please try again"
    end
    puts @player_board.render(true)

    loop do
      puts "Enter the squares for the Submarine (2 spaces):"
      player_picks = gets.chomp.upcase.split(" ")
      if @player_board.valid_coordinate?(player_picks) && @player_board.valid_placement?(@player_submarine, player_picks)
        @player_board.place(@player_submarine, player_picks)
        break
      end
      puts "Those are invalid coordinates.  Please try again"
    end
    puts @player_board.render(true)
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
    if @player_cruiser.sunk? && @player_submarine.sunk? && @computer_cruiser.sunk? && @computer_submarine.sunk? # This is a tie
      puts "---------------------------------------------"
      puts "|    What are the chances?  It's a TIE!     |"
      puts "---------------------------------------------"
      puts " "
      true
    elsif @player_cruiser.sunk? && @player_submarine.sunk? # Computer wins
      puts "---------------------------------------------"
      puts "| Haha, better luck next time HUMAN! I win! |"
      puts "---------------------------------------------"
      puts " "
      true
    elsif @computer_cruiser.sunk? && @computer_submarine.sunk? # Player wins
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