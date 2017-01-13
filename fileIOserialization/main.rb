## main.rb for Hangman Game
load "lib/hangman.rb"


## Init Hangman
game = Hangman.new

#Start game loop
while !game.finished?
	game.turn
end