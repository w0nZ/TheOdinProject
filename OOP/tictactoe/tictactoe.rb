#TicTacToe
class TicTacToe
	attr_accessor :player1, :board, :turn
	def initialize(player1, player2)
		self.welcome(player1, player2)
		@board = Board.new
		@player1 = Player.new(player1, "X")
		@player2 = Player.new(player2, "O")
		@turn = @player1
		@gameOver = false
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
				@gameOver = true
			elsif @board.board[first] == "O" && @board.board[second] == "O" && @board.board[third] == "O"
				winner("O")
				@gameOver = true
			end
		end
		return @gameOver
	end
	
	def winner(sign)
		if sign == @player1.sign
			puts "########Congrats #{@player1.name}!"
		elsif sign == @player2.sign
			puts "########Congrats #{@player2.name}!"
		end
		exit
	end
	
	def fin?
	#all fields used up, no winner
		@gameOver = true
		@board.board.each do |value|
			if value == "X" || value == "O"
				@gameOver = true
			else
				@gameOver = false
			end
		end
		puts "#########Finished, no Winner" if @gameOver
		return @gameOver
	end
	
	def draw(field)
	#If game has not ended
	field = field - 1
		if !@gameOver
		#If field isn't already used
			if !empty?(field)
				puts "no valid input, already choosen\n"
				puts "Please try again\n"
			elsif @turn == @player1
				@board.board[field] = @player1.sign
				self.turn = @player2
			elsif @turn == @player2 
				@board.board[field] = @player2.sign
				self.turn = @player1
			end
			@board.draw
		end
	end
	
	def turn?
		if !@gameOver
			if @turn == @player1
				print "\nIt's your turn #{@player1.name}, make your \"#{@player1.sign}\": "
			else
				print "\nIt's your turn #{@player2.name}, make your \"#{@player2.sign}\": "
			end
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
