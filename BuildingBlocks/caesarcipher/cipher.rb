def caesar_cipher ( text, shift )
	ciphre = ""
	text.split("").each do |char|
		if (char.ord >= 65 && char.ord <= 90) || (char.ord >= 97 && char.ord <= 122)
			charshift = char.ord+shift
			charshift -= 26 if (charshift > 90 && charshift < 97) || (charshift > 122) 
			ciphre += charshift.chr
		else
			ciphre += char
		end
	end
	return ciphre
end

def caesar_decipher ( text, shift )
	ciphre = ""
	text.split("").each do |char|
		if (char.ord >= 65 && char.ord <= 90) || (char.ord >= 97 && char.ord <= 122)
			charshift = char.ord-shift
			charshift += 26 if (charshift < 65) || (charshift < 97  && charshift > 90) 
			ciphre += charshift.chr
		else
			ciphre += char
		end
	end
	return ciphre
end


cipher =  caesar_cipher("That's how it works bro. Xylophon und Zebra and the AbC!", 5)
puts cipher
puts caesar_decipher(cipher, 5)