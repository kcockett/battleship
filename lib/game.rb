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
    self.computer_ship_setup
    self.player_ship_setup
    #run the game
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
      #require 'pry'; binding.pry
      player_picks = gets.upcase.chomp.split(" ")
      if @player_board.valid_coordinate?(player_picks) && @player_board.valid_placement?(@player_cruiser, player_picks) == true
        @player_board.place(@player_cruiser, player_picks)
        break
      end
      puts "Those are invalid coordinates.  Please try again"
    end
    puts @player_board.render(true)

    loop do
      puts "Enter the squares for the Submarine (2 spaces):"
      player_picks = gets.chomp.upcase.split(" ")
      if @player_board.valid_coordinate?(player_picks) && @player_board.valid_placement?(@player_submarine, player_picks) == true
        @player_board.place(@player_submarine, player_picks)
        break
      end
      puts "Those are invalid coordinates.  Please try again"
    end
    puts @player_board.render(true)
  end
  
  # pick a ship
    # input ship and coordinates
    # check if ship placement is valid
  # repeat for all ships
  


end