require_relative "./lib/game"

puts "--------------------The name of the game is--------------------"
puts "-------------------------CONNECT FOUR--------------------------"
puts "        Object: Connect four of your checkers in a row         "
puts "      while preventing your opponent from doing the same.      "
puts "But look out! Your opponent can sneak up on you and win the game."

loop do
  game = Game.new
  game.play
  break unless game.play_again?
end

puts "Pretty sneaky, Sis! Thanks for playing!"