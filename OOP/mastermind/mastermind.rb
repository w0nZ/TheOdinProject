##TheOdinProject Mastermind
class Mastermind
	attr_accessor :round, :guess

	def initialize(mode, kiName, humanName)
		@cheat = false
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
		##print the choosen Code on Screen
		print "Secret Code: "
		@code.each { |x| print "#{x} "}
		print "\n"
	end
	
	def welcome
		puts "###############################"
		puts "#### Welcome to MasterMind ####"
		puts "###############################"
		puts "Hi #{@human.name} you play vs #{@ki.name}(KI)"
	end
	
	def turn
		# Who needs to guess, ki or human, save guess, increment game round
		if @mode=="guess"
			#give round to human and save his guess
			@guess[@round-1] = @human.guess(@round)
			#let ki giveFeedback to human guess and save it
			@feedback[@round-1] = @ki.giveFeedback(@guess[@round-1], @code)
		else
			#give round, last round Feedback and last round Guess to ki
			@guess[@round-1] = @ki.guess(@round, @feedback[@round-2], @guess[@round-2])
			#let human (build in method of class Player) giveFeedback and save to @feedback
			@feedback[@round-1] = @human.giveFeedback(@guess[@round-1], @code)
		end
		@board.draw(@feedback, @guess, @round)
		@round += 1
	end
	
	def finished? 
	#Check if finishd
		fin = true
		if won?
			puts "##### Congrats you won #####"
		elsif lost? 
			puts "##### you lost #####"
		else
			fin = false
		end
		fin
	end
	
	def won?
		# won if guessing and 4 "!" before round 13 or coding and round > 13
		true if @feedback[@round-2] == ["!", "!", "!", "!"] && @mode == "guess" || @mode == "code" && @round > 13
	end
	
	def lost?
		# lost if opposite of won
		true if @feedback[@round-2] == ["!", "!", "!", "!"] && @mode == "code" || @mode == "guess" && @round > 13
	end
	
	class Player
	#Every Player has a name (even the KI)
		attr_accessor :name

		def initialize(name)
			@name = name
		end
	
		def blacksAndWhites(guess,code)
			# blacks = match, whites ? contains
			match = 0
			contains = 0
			unmatched_guess = []
			unmatched_code = []
			# check if guess equals code
			guess.each_with_index do |g, i|
				if g == code[i]
					match +=1
				# else save val from guess and code in unmatched
				else
					unmatched_guess << g
					unmatched_code << code[i]
				end
			end
			
			#look if you can get a index in the code 4 one of the unmatced guesses. 
			#If yes, remove the code-part and raise whites
			unmatched_guess.each do |g|
				index = unmatched_code.index(g)
				if !index.nil?
					unmatched_code.delete_at(index)
					contains += 1
				end
			end
			return match, contains
		end
		
		def giveFeedback(guess, code)
			match, contains = blacksAndWhites(guess, code)
			#take blacks and whites and put number of !,?,X in feedback array in number of balcks and whites
			comp = []
			(1..match).each {comp << "!"}
			(1..contains).each {comp << "?"}
			if match+contains < 4
				fill = 4 - match - contains
				(1..fill).each {comp << "X"}
			end
			return comp
		end
		
	end
	
	class Human < Player
	# Human class
		def guess(round)
			# get a guess, validate and split to arr
			puts "\n##### #{self.name} this is round #{round}"
			input = enterCode
			#puts "Input: #{input}"
			inputVal?(input)
			input.split("")
		end
		
		def inputVal?(input)
		#input Validation for guess or code gen
			while !(input =~ /[A-F]/ && input.length == 4) do
				puts "Sorry, valid input is A..F, 4 chars"
				input = gets.chomp
			end
		end
		
		def enterCode
			#gets a guess code or a secrete code
			puts "Please enter your Code, 4 chars A..F (f.e. 'ABCD'):"
			input = gets.chomp
			return input
		end
		
		def genCode
			# get a secret code.. very equal to "def guess".. stinks like redundant code
			input = enterCode
			inputVal?(input)
			input.split("")
		end
	end
	
	class Ki < Player 
	#Ki class from Player
		def initialize(name)
			@set = Array.new
			@name = name
			@possibilities = createSet
		end
	
		def guess(round, feedbackLR, guessLR)
			#following 4 lines are for troubleshooting
			#print "#{self.name} Guess round #{round} with GuessLastRound: "
			#guessLR.each {|glr| print glr}
			#print " and feedbackLastRound: "
			#feedbackLR.each {|f| print f}
			
			#compare last round guess with feedback and update remove codes not possible
			#starts with round 2
			updateSet(guessLR, feedbackLR) if round > 1
			if @possibilities.size == 1296
				#if possibilities are still from init, do some init guess
				kiguess = ["A","A","B","B"]
			else
				#else choose a sample from the updated set
				kiguess = @possibilities.sample
			end
			return kiguess
		end
	
		def updateSet(guess,feedback)	
			#delete possibilite if feedback of possibility from set does not equal last round feedback
			@possibilities.delete_if {|p| giveFeedback(p, guess) != feedback}	
			puts "Possibilities left: #{@possibilities.size}"
		end
	
		def genCode
			#gen 4 random chars and safe in arr
			code = []
			for i in 0..3
				code[i] = genChar
			end
			return code
		end
		
		def genChar
			#generate a Random char from A to F
			(65 + rand(6)).chr
		end
		
		def createSet
			set = []
			('A'..'F').each do |c1|
				('A'..'F').each do |c2|
					('A'..'F').each do |c3|
						('A'..'F').each do |c4|
							set << [c1, c2, c3, c4]
						end
					end
				end
			end
			return set
		end		
		
	end
	

	class Board
	#Board class, just draws the layout 
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