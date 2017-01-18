#hangman
class Hangman

	def initialize()
		require 'yaml'
		@cheat = false
		#start with welcome
		welcome
	end

## Only turn method and finished method are available to public
	def turn
		outputStatus
		if @guesses_left < 10
			saveGame if save?
		end
		letter = getLetter
		if checkLetter(letter)
			replaceLetter(letter)
		else
			wrongGuess(letter)
		end
	end
	
	def finished?
		if won? || lost?
			true
		else
			false
		end
	end	
	
## All else can be secret
	private
	def anonymiseSecret
		#place a "_" for every char in secret word
		@secret_word.gsub(/./, '_')
	end
	
	def getWord
		#load words from dictionary with length >=5 and <=12 and give back a sample
		words = []
		dict = File.open("5desk.txt", "r")
		dict.each {|w| words << w if w.length >= 5 and w.length <= 12 }
		words.sample
	end

## Some Output Methods
	def welcome
		#Welcome and ask for load or new
		puts "####\nHi Bro, Welcome to a round of Hangman"
		puts "Wanna start a 'new' game or 'load' a already started one?"
		input = gets.chomp
		newOrLoad(input)
	end 
	
	def outputStatus
		# Output actual status of the game, avail guesses, etc
		puts "Hi Bro, you have #{@guesses_left} guesses left"
		if @incorrect_letters.length > 0
			print "Incorrect letters so far: "
			@incorrect_letters.each { |l| print "#{l} "}
			puts ""
		end
		puts "The secret is #{@secret_word}" if @cheat
		print "The word to guess: "
		@guessed_word.split("").each { |s| print s + " "}
	end

	def outputWon
		puts "#### Yeah Bro, you did it ####"
		puts "You had #{@guesses_left} guesses left and the secret word was '#{@secret_word.chomp}'"
	end

	def outputLost
		puts "#### Sorry Bro, you lost ####"
		puts "The secret word was '#{@secret_word.chomp}' and youn found out '#{@guessed_word.chomp}' so far"
	end
### End Output Methods
	def newOrLoad(input)
		if input == "new"
			initVars
		else
			loadGame
		end
	end

	def initVars
		#initialize the vars, if new game
		@secret_word = getWord
		@guessed_word = anonymiseSecret
		@guesses_left = 10
		@incorrect_letters = []
	end
	
	def save?
		begin
			puts "Do you want to save and exit the game? (y/n)"
			answer = gets.chomp
		end while !valSave(answer)
		if answer == "y"
			saveGame 
			exit
		#hidden cheat function
		elsif answer == "e"
			@cheat = true
		end
	end
	
	def valSave(answer)
	#Val if answer for save is either y, n or e
		if answer =~ /[yne]/ && answer.length == 1
			true
		end
	end
	
	def getFilename
		puts "Please enter Filename:"
		gets.chomp
	end
	
	def saveGame
	#save the game in YAML format
		if !Dir.pwd.include? "saves"
			Dir.mkdir("saves") unless Dir.exists? "saves"
			Dir.chdir("saves")
		end
		saveFile = File.open(getFilename, "w")
		saveFile.write to_yaml
		saveFile.close
	end

	def listSavegames
	#Show all savegames
		Dir.chdir("saves") if !Dir.pwd.include? "saves" 
		games = Dir["*"]
		puts "The following savegames exist:"
		games.each { |game| puts game}
	end
	
	def loadGame
	#Load Game from_yaml
		listSavegames
		filename = getFilename
		loadFile = File.open("../saves/" + filename, "r")
		from_yaml(loadFile)
	end
	
	def to_yaml
	#dump all needed vars to YAML
		YAML.dump ({
			:secret_word => @secret_word,
			:guessed_word => @guessed_word,
			:guesses_left => @guesses_left,
			:incorrect_letters => @incorrect_letters
		})
	end	

	def from_yaml(string)
	#Get all needed Vars from yaml
		data = YAML.load string
		@secret_word = data[:secret_word]
		@guessed_word = data[:guessed_word]
		@guesses_left = data[:guesses_left]
		@incorrect_letters = data[:incorrect_letters]
	end
	
	def wrongGuess(letter)
	#save incorrect letters
		@incorrect_letters << letter
		puts "Sorry Bro, the letter '#{letter}' is not in the secret word"
		@guesses_left = @guesses_left - 1
	end
	
	def getLetter
	#Ask and get Letter
		begin
			puts "\nPlease Enter a valid letter '[a-z]':"
			letter = gets.chomp
		end while !valLetter(letter)
		letter
	end
	
	def valLetter(letter)
	#validate input
		if letter =~ /[a-z]/ && letter.length == 1
			true
		else
			false
		end
	end
	
	def checkLetter(letter)
		if @secret_word.include?(letter) || @secret_word.include?(letter.upcase)
			true
		else
			false
		end
	end
	

	
	def won?
		if allLettersGuessed?
			outputWon
			true
		end
	end
	
	def allLettersGuessed?
		if !@guessed_word.include?("_")
			true
		else
			false
		end
	end
	
	def lost?
		if @guesses_left < 1
			outputLost
			true
		end
	end
	
	def replaceLetter(letter)
		#get all occurences(index) of letter in @secret_word
		occurrences = (0...@secret_word.length).find_all { |i| @secret_word[i,1] == letter}
		#loop through occurences and use as index for @guessed_word to set replace the "_" with letter
		occurrences.each do |occurrence|
			@guessed_word[occurrence] = letter
		end
		#set first letter upcase if it is upcase in secret word
		@guessed_word[0] = letter.upcase if @secret_word[0] == letter.upcase
	end

end