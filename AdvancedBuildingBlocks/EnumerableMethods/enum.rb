#Module numerable methods
module Enumerable
	def my_each
		return self unless block_given?
		for i in (0...self.length)
			yield(self[i])
		end
	end
	
	def my_each_with_index
		return self unless block_given?
		for i in (0...self.length)
			yield(self[i],i)
		end
	end
	
	def my_select
		return self unless block_given?
		selectArr = []
		self.my_each { |v| selectArr << v if yield(v)}
		selectArr
	end
	
	def my_all?
		return self unless block_given?
		self.my_each do |v|
			return false if yield(v) == false
		end
		true
	end	
	
	def my_any?
		return self unless block_given?
		self.my_each do |v|
			return true if yield(v) == true
		end
		false
	end	
	
	def my_none?
		return self unless block_given?
		self.my_each do |v|
			return false if yield(v) == true
		end
		true
	end
	
	def my_count (*compare)
		if block_given?
			puts "my_count with block"
			self.my_select { |i| yield i }.length
		elsif compare.length == 1
			puts "my_count with equal to "
			self.my_select { |i| i == compare[0] }.length
		else
			puts "my_count std"
			self.length
		end
	end
	
	def my_map(code = nil, &block)
		arr = []
		if block_given? && code == nil
			self.my_each { |n| puts "Block given"; arr << block.call(n) }
		elsif block_given? && code != nil
			self.my_each { |n| puts "Block and Code given"; arr << block.call(n) }		
		else 
			self.my_each { |n| puts "Proc given"; arr << code.call(n) }		
		end
		arr
	end
	
	def my_inject(start = nil)
		if start
			self.my_each { |n| start = yield(start, n)}
		else
			self.my_each_with_index do |n, i|
				if i == 0
					start = self[i]
					next
				end
				start = yield(start, n)
			end
		end
		start
	end
end



####Tests for my enums
arr = [1,2,3,4,5,6]
puts "test my_each [1,2,3,4,5,6]"
arr.my_each {|value| puts value}
puts "compare each [1,2,3,4,5,6]"
arr.each {|value| puts value}

puts "test_my_each_with_index [1,2,3,4,5,6]"
arr.my_each_with_index { |value,index| puts "index= " + index.to_s + " value= " + value.to_s }
puts "compare each_with_index [1,2,3,4,5,6]"
arr.each_with_index { |value,index| puts "index= " + index.to_s + " value= " + value.to_s }

puts "test my_select [1,2,3,4,5,6] even?"
puts arr.my_select { |num|  num.even?  }
puts "compare select [1,2,3,4,5,6] even?"
puts arr.select { |num|  num.even?  }

puts "test my all? [1,2,3,4,5,6] >= 0"
puts "true" if arr.my_all? { |num| num >= 0 }
puts "test all? [1,2,3,4,5,6] >= 0"
puts "works" if arr.all? { |num| num >= 0 }

puts "test my any? [1,2,3,4,5,6] > 5"
puts "true" if arr.my_any? { |num| num > 5 }
puts "test any? [1,2,3,4,5,6] > 5"
puts "true" if arr.any? { |num| num > 5 }

puts "test my none? [1,2,3,4,5,6] < 0"
puts "true" if arr.my_none? { |num| num < 0 }
puts "test none? [1,2,3,4,5,6] < 0"
puts "true" if arr.none? { |num| num < 0 }

puts "test my_count [1, 2, 4, 2] { |x| x%2==0 }"
puts [1, 2, 4, 2].my_count { |x| x%2==0 }
puts "test count [1, 2, 4, 2] { |x| x%2==0 }"
puts [1, 2, 4, 2].count { |x| x%2==0 }
puts "test my_count [1, 2, 4, 2] "
puts [1, 2, 4, 2].my_count
puts "test count [1, 2, 4, 2] "
puts [1, 2, 4, 2].count
puts "test my_count(2) [1, 2, 4, 2] "
puts [1, 2, 4, 2].my_count(2)
puts "test count(2) [1, 2, 4, 2] { |x| x%2==0 }"
puts [1, 2, 4, 2].count(2)

proc = Proc.new { |n| n*n }
puts "test (1..3).my_map { |i| i*i } "
puts [1,2,3].my_map { |i| i*i } 
puts "compare (1..3).map { |i| i*i } "
puts [1,2,3].map { |i| i*i } 
puts "test (1..3).my_map (proc)"
puts [1,2,3].my_map (proc) 

puts "test my_inject"
puts arr.my_inject {|x,y| x + y}
puts arr.inject {|x,y| x + y}
puts arr.my_inject(1) {|x,y| x * y}
puts arr.inject(1) {|x,y| x * y}
