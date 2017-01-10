#main.rb
load 'mastermind.rb'

#Get user names
#puts "Please enter a name for the KI: "
#name1 = gets.chomp
#puts "Please enter your name: "
#name2 = gets.chomp
#Get game mode
#puts "Choose game mode 'guess' or 'code'
#mode = gets.chomp

#init game
#game = Mastermind.new(name1, name2, mode)
game = Mastermind.new("CyBoRg", "Human")
#play until tie or win
while !game.finished?
	game.turn
end