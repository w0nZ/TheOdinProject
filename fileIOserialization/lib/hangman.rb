#hangman
class Hangman

	def initialize()
		require 'yaml'
		@cheat = false
		@secret_word = getWord
		@guessed_word = anonymiseSecret
		@guesses_left = 10
		@incorrect_letters = []
	end

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
		@secret_word.gsub(/./, '_')
	end
	
	def getWord
		words = []
		dict = File.open("5desk.txt", "r")
		dict.each {|w| words << w if w.length >= 5 and w.length <= 12 }
		words.sample
	end

## Some Output Methods
	def outputStatus
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

	def save?
		begin
			puts "Do you want to save and exit the game? (y/n)"
			answer = gets.chomp
		end while !valSave(answer)
		if answer == "y"
			saveGame 
			exit
		end
	end
	
	def valSave(answer)
		if answer =~ /[yn]/ && answer.length == 1
			true
		end
	end
	
	def saveGame
		saveFile = File.open("save.yaml", "w")
	end
	
	def wrongGuess(letter)
		@incorrect_letters << letter
		puts "Sorry Bro, the letter '#{letter}' is not in the secret word"
		@guesses_left = @guesses_left - 1
	end
	
	def getLetter
		begin
			puts "\nPlease Enter a valid letter '[a-z]':"
			letter = gets.chomp
		end while !valLetter(letter)
		letter
	end
	
	def valLetter(letter)
		if letter =~ /[a-z]/
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
		occurrences = (0...@secret_word.length).find_all { |i| @secret_word[i,1] == letter}
		occurrences.each do |occurrence|
			@guessed_word[occurrence] = letter
		end
		@guessed_word[0] = letter.upcase if @secret_word[0] == letter.upcase
	end

end