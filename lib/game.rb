require './lib/cell'
require './lib/ship'
require './lib/board'

class Game

  attr_reader :player_cruiser, 
              :player_submarine, 
              :computer_cruiser, 
              :computer_submarine
  def initialize
    @player_cruiser = Ship.new("Cruiser", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  # def main_menu
  #   puts "Welcome to BATTLESHIP"
  #   puts "Enter p to play.  Enter q to quit."
  #   until player_response == "p" || "q"
  #     player_response == gets.chomp
  #       puts "Sorry, invalid selection.  Please try again."
  #     end
  #     if  player_response == "p"
  #       # Start the game setup
  #       game = Game.new
  #       #
  #     elsif player_response == "q"
  #       game.good_bye
  #     end
  #   end
  # end

  # def good_bye
  #   puts "Thanks for playing"
  #   exit
  # end
end