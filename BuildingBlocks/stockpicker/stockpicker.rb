#stock picker
#Implement a method #stock_picker that takes in an array of stock prices, 
#one for each hypothetical day. It should return a pair of days representing
#the best day to buy and the best day to sell. Days start at 0.

def stock_picker (stock)
	highest, buy4, sell4 = 0
	days = []
	selltime = stock.drop(1)
	stock.take(stock.size-1).each do |buy|
		selltime.each do |sell|
			if (sell - buy) > highest
				buy4 = buy
				sell4 = sell
				highest = sell - buy
			end
		end
		selltime = selltime.drop(1)
	end
	days[0] = stock.index(buy4)
	days[1] = stock.index(sell4)
	puts "For a max profit of #{highest} buy for #{buy4} on day #{days[0]} and sell for #{sell4} on day #{days[1]}."
end

puts stock_picker([17,3,6,9,15,8,6,1,10])