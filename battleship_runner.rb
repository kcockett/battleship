require './lib/game'
include Sayable

puts "Welcome to BATTLESHIP"
puts "Enter p to play.  Enter q to quit."
say("Welcome to BATTLESHIP")
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
    say("Would you like to play again?")
end

puts "Thanks for playing"
say("Thanks for playing")