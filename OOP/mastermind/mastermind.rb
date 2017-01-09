##TheOdinProject Mastermind

class Mastermind

	attr_accessor :round, :guess

	def initialize(mode="guess", kiName, humanName)
		@mode = mode
		@board = Board.new
		@guess = Hash.new
		@ki = Ki.new(kiName)
		@human = Human.new(humanName)
		@round = 1
		@feedback = Array.new(12) {Array.new(4)}
		@guess = Array.new(12) {Array.new(4)}
		@code = @ki.genCode
		#@guess[round-1] = @human.guess(@round)
		#compare
		#@board.draw(@feedback, @guess, @round)
	end
	
	def compare
		i = 0
		comp = []
		@guess[@round-1].each do |val|
			if @code[i] == val
				comp << "!"
			elsif @code.include? val
				comp << "?"
			end
			i += 1
		end
		@feedback[@round-1] = comp
	end
	
	class Player
		attr_accessor :name

		def initialize(name)
			@name = name
		end
	end
	
	class Human < Player

		def guess(round)
			puts "Hi #{self.name} this is round #{round}"
			guesses = []
			for i in 0..3
				puts "Please insert guess #{i}:"
				guesses << gets.chomp
			end
			guesses 
		end
	end
	
	class Ki < Player 
		def genCode
			code = []
			for i in 1..4
				code[i] = (65 + rand(6)).chr
			end
			##CheatMode
			print "Secret Code: "
			code.each { |x| print "#{x} "}
			print "\n"
			##CheatMode
			return code
		end
	end
	

	class Board
		def initialize
		end
		
		def draw(feedback, guess, round)
			puts "The status of the Code-Board:"
			for n in 0..round-1
				print "Round: #{round} | Feedback: "
				feedback[n].each { |f| print "#{f} "}
				print "| Guess: "
				guess[n].each { |g| print "#{g} "}
				puts "\n"
			end
		end	
	end

end

myGame = Mastermind.new("CyBoRg", "Human")
