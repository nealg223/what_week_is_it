require 'sinatra'
require 'nokogiri'
require 'open-uri'
require 'date'
calander_url = "http://event.uchicago.edu/academic-calendar/"

#What follows is good old fashion screen scraping
#Basically just find the first date class and scrape the date out of the html
full_calander = Nokogiri::HTML( open( calander_url ) )
matches = full_calander.xpath('//td[@class="date"]')
start_date = matches[0].text.scan(/\w{3}.* \d/)[0]
month = case start_date[0...3]
  when "Jan" then 1
  when "Feb" then 2
  when "Mar" then 3
  when "Apr" then 4
  when "May" then 5
  when "Jun" then 6
  when "Jul" then 7
  when "Aug" then 8
  when "Sep" then 9 
  when "Oct" then 10
  when "Nov" then 11
  when "Dec" then 12
end
today_date = DateTime.now
start_quarter = DateTime.new(today_date.year, month, start_date[5].to_i - 1)

# Yeah the arithmetic here is a little shoddy, I hate floats

#The actual server stuff is only 4 lines!
get '/' do
  today_date = DateTime.now
  days_from_start = (today_date-start_quarter).to_i
  @week = days_from_start/7 + 1
  erb :what_week
end

__END__

# This is an in-file erb
@@ what_week
<h1>IT'S WEEK <%= @week %>!</h1>
