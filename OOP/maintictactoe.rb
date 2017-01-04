#main.rb
load 'tictactoe.rb'

#Get user names
puts "Player1 please enter your Name: "
name1 = gets.chomp
puts "Player2 please enter your Name: "
name2 = gets.chomp

#init game
game = TicTacToe.new(name1, name2)
#play until tie or win
while !game.win? && !game.fin?
	game.turn?
	choice = gets.chomp
	game.draw(choice.to_i)
end