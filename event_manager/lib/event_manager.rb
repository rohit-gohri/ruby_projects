require 'csv'
require 'sunlight/congress'
require 'erb'
require 'date'

Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_no(number)
  nums = /\D*(\d+)\D*(\d+)\D*(\d+)/.match(number)
  num = nums[1] + nums[2] + nums[3]
  if num.length == 11 && num[0] == 1
    num[1..10]
  elsif num.length != 10
    "0000000000"
  else
    num
  end
end

def legislators_by_zipcode(zipcode)
  legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists?("output")

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def date_extract(date)
  DateTime.strptime(date,"%m/%d/%y %k:%M")
end

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol

template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter
hours = Array.new(24) {0}
days = Array.new(7) {0}
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  #number = clean_phone_no(row[:homephone])
  date = date_extract(row[:regdate])
  zipcode = clean_zipcode(row[:zipcode])
  #legislators = legislators_by_zipcode(zipcode)
  #form_letter = erb_template.result(binding)
  hours[date.hour] += 1
  days[date.wday] += 1
end
week = {0 => 'Sunday', 1 => 'Monday', 2 => 'Tuesday', 3 => 'Wednesday', 4 => 'Thursday', 5 => 'Friday', 6 => 'Saturday'}
day = days.each_with_index.max
hour = hours.each_with_index.max
puts "Day with max registrations - #{week[day[1]]} : #{day[0]}"
puts "Hour with max registrations - #{hour[1]} : #{hour[0]}"
