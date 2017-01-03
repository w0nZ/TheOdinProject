#TicTacToe
class TicTacToe
	attr_accessor :player1, :board, :turn
	def initialize(player1, player2)
		self.welcome(player1, player2)
		@board = Board.new
		@player1 = Player.new(player1, "X")
		@player2 = Player.new(player2, "O")
		@turn = @player1
		self.turn?
	end

	def welcome(name1, name2)
		puts "### Welcome #{name1} and #{name2} to a new game TicTacToe"
	end	

	def win?
	#three in a row
		@winPos = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [6,4,2], [0,3,6], [1,4,7], [2,5,8]]
		@winPos.each do |num|
			first, second, third = num
			if @board.board[first] == "X" && @board.board[second] == "X" && @board.board[third] == "X"
				winner("X")
			elsif @board.board[first] == "O" && @board.board[second] == "O" && @board.board[third] == "O"
				winner("O")
			end
		end
	end
	
	def winner(sign)
		if sign == @player1.sign
			puts "Congrats #{@player1.name}!"
		elsif sign == @player2.sign
			puts "Congrats #{@player2.name}!"
		end
		exit
	end
	
	def fin?
	#all fields used up, no winner
		noWinner = true
		@board.board.each do |num|
			if num == "X" && num == "O"
				noWinner = true
			else
				noWinner = false
				break
			end
		end
		puts "Finished, no Winner" if noWinner
	end
	
	def draw(field)
		if !empty?(field-1)
			puts "no valid input, already choosen\n"
			puts "Please try again\n"
		elsif @turn == @player1
			@board.board[field-1] = @player1.sign
			self.turn = @player2
		elsif @turn == @player2 
			@board.board[field-1] = @player2.sign
			self.turn = @player1
		end
		@board.draw
		win?
		fin?
		turn?
	end
	
	def turn?
		if @turn == @player1
			puts "It's your turn #{@player1.name}"
		else
			puts "It's your turn #{@player2.name}"
		end
	end
	
	def empty?(field)
		if @board.board[field] == "X" || @board.board[field] == "O"
			false
		else
			true
		end
	end
	
	class Player
		attr_accessor :name, :sign
		
		def initialize(name, sign)
			@name = name
			@sign = sign
		end
	end

	class Board
		attr_accessor :board
		def initialize
			@board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
			self.draw
		end
		
		def draw
			puts "The status of the board:"
			print " #{@board[0]} | #{@board[1]} | #{@board[2]}\n---+---+---\n #{@board[3]} | #{@board[4]} | #{@board[5]}\n---+---+---\n #{@board[6]} | #{@board[7]} | #{@board[8]}\n"
			puts ""
		end
		
	end

end

##Initiate
#myGame = TicTacToe.new("Ursula", "Domian")
##Test Game Winning Ursula with "failpick"
##Ursula
#myGame.draw(1)
##Domian failpick
#myGame.draw(1)
##Domian again
#myGame.draw(3)
##Ursula
#myGame.draw(4)
##Domian
#myGame.draw(5)
##Ursula
#myGame.draw(7)


drawGame = TicTacToe.new("Ulf", "Aaron")
#Ulf X
drawGame.draw(1)
#Aaron O
drawGame.draw(5)
#Ulf X
drawGame.draw(4)
#Aaron O
drawGame.draw(7)
#Ulf X
drawGame.draw(8)
#Aaron O
drawGame.draw(6)
#Ulf X
drawGame.draw(3)
#Aaron O
drawGame.draw(2)
#Ulf X
drawGame.draw(9)



