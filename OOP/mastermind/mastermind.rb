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
		@gameOver = false
		#@guess[round-1] = @human.guess(@round)
		#compare
		#@board.draw(@feedback, @guess, @round)
	end
	
	def turn
		if @mode=="guess"
			@guess[@round-1] = @human.guess(@round)
		else
			puts "not yet implemented"
		end
		compare
		@board.draw(@feedback, @guess, @round)
		@round += 1
	end
	
	def finished? 
		if @feedback[@round-2] == ["!", "!", "!", "!"]
			puts "congrats you won"
			return true
		elsif @round > 12
			puts "you lost"
			return true
		end
	end
	
	def compare
		i = 0
		comp = []
		@guess[@round-1].each do |val|
			puts "Value: #{val}"
			if @code[i] == val
				#puts @code[i] + "==" + val
				puts "hits equal"
				comp << "!"
			elsif @code.include? val
				#puts @code[i] + "contains" + val
				puts "hits include"
				comp << "?"
			else
				#puts @code[i] + "not contains" + val
				comp << "X"
				puts "hits not in"
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
			for i in 1..4
				puts "Please insert guess #{i}:"
				guesses << gets.chomp
			end
			guesses 
		end
	end
	
	class Ki < Player 
		def genCode
			code = []
			for i in 0..3
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
		def draw(feedback, guess, round)
			puts "The status of the Code-Board:"
			for n in 0..11
				print "Round: #{n+1} | Feedback: "
				feedback[n].each { |f| print "#{f} "}
				print "| Guess: "
				guess[n].each { |g| print "#{g} "}
				puts "\n"
			end
		end	
	end

end

#myGame = Mastermind.new("CyBoRg", "Human")
