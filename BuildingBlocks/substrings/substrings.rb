#substrings
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings ( string , dict )
	counts = Hash.new(0)
	string.downcase!
	dict.each do |word|
		if string.include?(word)
			counts[word] = string.scan(word).length
		end
	end
	puts counts
end

substrings("below", dictionary)
substrings("Howdy partner, sit down! How's it going?", dictionary)