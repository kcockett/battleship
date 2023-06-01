require './lib/game'
require './lib/ship'
require './lib/board'
require './lib/cell'
require './lib/sayable'
include Sayable

puts "Welcome to BATTLESHIP"
puts "Enter p to play.  Enter q to quit."
`say -r 90 -v Fred "Welcome to BATTLESHIP"`
loop do
  player_response = gets.downcase.chomp
  
  if  player_response == "p"
    game = Game.new 
    game.start_ship_placement
  elsif player_response == "q"
    break
  else
    puts "Sorry, invalid selection.  Please try again."
  end
    puts "Would you like to play again?"
    puts "Enter p to play.  Enter q to quit." 
end

puts "Thanks for playing"
`say -r 90 -v Fred "Thanks for playing"`