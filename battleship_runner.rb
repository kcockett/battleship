require './lib/game'

puts "Welcome to BATTLESHIP"
puts "Enter p to play.  Enter q to quit."
until player_response == "p" || "q"
  player_response == gets.chomp
    puts "Sorry, invalid selection.  Please try again."
  end
  if  player_response == "p"
    # Start the game setup
  elsif player_response == "q"
    break
  end
end
puts "Thanks for playing"