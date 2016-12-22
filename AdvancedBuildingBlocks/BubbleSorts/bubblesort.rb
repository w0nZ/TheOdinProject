#bubblesort

def bubble_sort(arr)
	n = arr.length
	loop do
	swapped = false
		for i in (1..n-1)
			if arr[i-1] > arr[i]
				arr[i-1], arr[i] = arr[i], arr[i-1]
				swapped = true
			end
		end
		break if swapped == false
	end
	return arr
end

array = [4,3,78,2,0,2]
puts bubble_sort(array)

def bubble_sort_by(arr)
	n = arr.length
	loop do
	swapped = false
		for i in (1..n-1)
			y = yield arr[i-1],arr[i]
			if yield(arr[i-1],arr[i]) >= 1
				arr[i-1], arr[i] = arr[i], arr[i-1]
				swapped = true
			end
		end
		break if swapped == false
	end
	return arr
end

puts bubble_sort_by(["hey","hi","hello","hola","hi","hello","hey"]) { |left,right| left.length - right.length }
