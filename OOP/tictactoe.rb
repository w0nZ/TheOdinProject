#TicTacToe
class TicTacToe
	def initialize(player1, player2)
		self.welcome
		@board = Board.new
		@player1 = Player.new(player1)
		@player2 = Player.new(player2)

	end

	def welcome
		puts "### Welcome to a new game TicTacToe"
	end
	
	class Player
		def initialize(name)
			@name = name
		end
	end
	
	class Board
		attr_accessor :field
		def initialize
			@field = { a1: " ", b1: " ", c1: " ", a2: " ", b2: " ", c2: " ", a3: " ", b3: " ", c3: " "}
			self.draw
		end
		
		def draw
			i = 1
			puts "The status of the board:"
			@field.each do |k,v|
				print i if v == " "
				if i % 3 == 0
					print v + "\n"
				else
					print v + " | " 
				end
			i += 1
			end
		end
		
	end

end

myGame = TicTacToe.new