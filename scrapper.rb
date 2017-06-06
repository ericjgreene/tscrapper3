require 'nokogiri'

file = File.open('SteveJobsWikipedia.htm')
html = Noko)giri::HTML(file)

output = File.new( 'steve-jobs-story.txt', 'w+')

name = html.at_css('#firstHeading').text
bday = html.at_css('.bday').text
dday = html.at_css('.dday').text
cause_of_death = html.at_xpath('//a[@title="Pancreatic cancer"]').text

output.write( name + ' was born on ' + bday + "\n" )
output.write( 'He died on ' + dday + " due to " + cause_of_death 