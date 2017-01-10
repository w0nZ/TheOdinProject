##TheOdinProject Mastermind

class Mastermind
	attr_accessor :round, :guess

	def initialize(mode="guess", kiName, humanName)
		@mode = mode
		@board = Board.new
		@guess = Hash.new
		@ki = Ki.new(kiName)
		@human = Human.new(humanName)
		self.welcome
		self.gameMode(@mode)
		@round = 1
		@feedback = Array.new(12) {Array.new(4)}
		@guess = Array.new(12) {Array.new(4)}
	end

	def gameMode(mode)
	#Select if guessing or Code
		if mode == "guess"
			@code = @ki.genCode
		elsif mode == "code"
			@code = @human.genCode
		end
	end
	
	def welcome
		puts "###############################"
		puts "#### Welcome to MasterMind ####"
		puts "###############################"
		puts "Hi #{@human.name} you play vs #{@ki.name}(KI)"
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
	#Check if finishd
		if @feedback[@round-2] == ["!", "!", "!", "!"]
			puts "##### Congrats you won #####"
			return true
		elsif @round > 12
			puts "you lost"
			return true
		end
	end
	
	def compare
	#compare the actual guesses with the code save feedback in @feedback
		i = 0
		comp = []
		@guess[@round-1].each do |val|
			#puts "Value: #{val}"
			if @code[i] == val
				#puts "hits equal"
				comp << "!"
			elsif @code.include? val
				#puts "hits include"
				comp << "?"
			else
				#puts "hits not in"
				comp << "X"
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
			input = enterCode
			puts "Input: #{input}"
			inputVal?(input)
			input.split("")
		end
		
		def inputVal?(input)
			while !(input =~ /[A-F]/ && input.length == 4) do
				puts "Sorry, valid input is A..F, 4 chars"
				puts "Please insert your guess:"
				input = gets.chomp
			end
		end
		
		def enterCode
			puts "Please enter your Code, 4 chars A..F (f.e. 'ABCD'):"
			input = gets.chomp
			return input
		end
		
		def genCode
			input = enterCode
			inputVal?(input)
			input.split("")
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