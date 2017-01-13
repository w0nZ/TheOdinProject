##event_manager.rb
require "csv"
puts "EventManager Initialized!"

#manually parsing csv
#lines = File.readlines "event_attendees.csv"
#lines.each_with_index do |line, index|
#	next if index == 0
#	columns = line.split(",")
#	name = columns[2]
#	puts name
#end

#using lib csv

def cleanZipcode(zipcode)
	zipcode.to_s.rjust(5,"0")[0..4]
end

contents = CSV.open "event_attendees.csv", headers: true, header_converters: :symbol
contents.each do |row|
	name = row[:first_name]
	zipcode = cleanZipcode(row[:zipcode])
	
	puts "#{name} #{zipcode}"
end