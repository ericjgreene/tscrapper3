require 'mechanize'
require 'csv'

# Our seach terms
search_terms = ['henry ford', 'steve jobs', 'ray kroc', 'charlie murphy']

# This is where we setup mechanize
agent = Mechanize.new { |agent|
	agent.user_agent_alias = 'Mac Safari'
}

# This is where we setup page
page = agent.get('https://www.wikipedia.org//')
search_form = page.form(:action => '//www.wikipedia.org/search-redirect.php')

search_terms.each do |term|
	search_form.search = term
	results = agent.submit(search_form, search_form.button('go'))
	html_results = Nokogiri::HTML(results.body)

	name = html_results.at_css('#firstHeading').text
	bday = html_results.at_css('.bday').text
	dday = html_results.at_css('.dday').text

	# puts name + ' was born on ' + bday + ' and died on ' + dday + '.'

	CSV.open('life-data.csv', 'a+') do |csv|
		csv << [name, bday, dday]
	end

	delay_time = rand(11)
	sleep(delay_time)
	puts name + ' was just added to the CSV.'

end