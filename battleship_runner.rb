# require './lib/game'
# require './lib/ship'
# require './lib/board'
# require './lib/cell'

# available_ships = {}
# available_ships["Cruiser"] = 3
# available_ships["Submarine"] = 2

puts "Welcome to BATTLESHIP"
puts "Enter p to play.  Enter q to quit."
#player_response = ""
loop do
  player_response = gets.downcase.chomp
  
  if  player_response == "p"
    game = Game.new 
    game.start_setup
  elsif player_response == "q"
    break
  else
    puts "Sorry, invalid selection.  Please try again."
  end
end

puts "Thanks for playing"