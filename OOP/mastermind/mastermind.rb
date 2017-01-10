##TheOdinProject Mastermind

class Mastermind
	attr_accessor :round, :guess

	def initialize(mode, kiName, humanName)
		@cheat = true
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
		#show Cheat code
		self.cheat if @cheat
	end

	def cheat
		##CheatMode
		print "Secret Code: "
		@code.each { |x| print "#{x} "}
		print "\n"
		##CheatMode
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
			@guess[@round-1] = @ki.guess(@round,@feedback[@round-2],@guess[@round-2])
		end
		compare
		@board.draw(@feedback, @guess, @round)
		@round += 1
	end
	
	def finished? 
	#Check if finishd
		if @feedback[@round-2] == ["!", "!", "!", "!"] && @mode == "guess"
			puts "##### Congrats you won #####"
			return true
		elsif @feedback[@round-2] == ["!", "!", "!", "!"] && @mode == "code"
			puts "##### you lost #####"
			return true
		elsif @mode == "guess" && @round > 12
			puts "##### you lost #####"
			return true		
		elsif @mode == "code" && @round > 12
			puts "##### Congrats you won #####"
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
			#puts "Input: #{input}"
			inputVal?(input)
			input.split("")
		end
		
		def inputVal?(input)
			while !(input =~ /[A-F]/ && input.length == 4) do
				puts "Sorry, valid input is A..F, 4 chars"
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
				code[i] = genChar
			end
			return code
		end
		
		def genChar
			(65 + rand(6)).chr
		end
		
		def guess(round, feedback, guess)
			#give last guess and last feedback must be rewritten
			puts "KI #{self.name} guess. This is round #{round}"
			if round > 1
				kiguess = []
				i=0
				feedback.each do |f|
					if f == "!"
						kiguess[i] = guess[i]
					else
						kiguess[i] = genChar
					end
					i += 1
				end
			else
				kiguess = genCode
			end
			kiguess
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