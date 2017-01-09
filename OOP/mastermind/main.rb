#main.rb
load 'mastermind.rb'

#Get user names
#puts "Player1 please enter your Name: "
#name1 = gets.chomp
#puts "Player2 please enter your Name: "
#name2 = gets.chomp

#init game
game = Mastermind.new("CyBoRg", "Human")
#play until tie or win
while !game.finished?
	game.turn
end