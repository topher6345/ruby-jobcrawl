jobkeywordspattern = /\s*ruby\s*|\s*software\s*|\s*engineer\s*|\s*coding\s*|\s*developer\s*|\s*web\s*|\s*programmer\s*|\s*iOS\s*|\s*wordpress\s*|\s*music\s*|\s*guitar\s*/i

companiespattern = /companies/i
cleanpattern = /\/Jobs\/(.*)\.aspx/i
locationpattern = /\s*CA\b|\s*San Francisco\s*|\s*San Jose\s*|\s*San Carlos\s*|\s*Santa Clara\s*|\s*Mountain View\s*/i

site = 'http://www.startuply.com'

puts "<div class='panel panel-default'>"
puts  "<div class='panel-heading'><h3>" + site + "</h3></div>"

puts "<table border=3px class='table'>"
puts "<thead><tr><th>Location</th><th>Position</th><th>Company</th></thead>"

i = 1
while i < 15 do

	site_options = site + '/Default.aspx?p=' + i.to_s 
	doc = Nokogiri::HTML(open(site_options))
	
	j = 0 
	# For every link in the td tag
	while j < doc.css('td a').size do 
		if (doc.css('td a')[3 + j * 4])
			company  = doc.css('td a')[0 + j * 4]
			job      = doc.css('td a')[1 + j * 4]
			location = doc.css('td a')[3 + j * 4]
				#location 
				if locationpattern.match(location.children.text).to_s.empty?
					# puts "skip:" + location.children.text + "<br />"

				else 
					# puts "match:" + location.children.text + "<br />"
					if jobkeywordspattern.match(job.children.text).to_s.empty?
						# puts "&nbsp;&nbsp;&nbsp;&nbsp;skip:" + job.children.text + "<br />"
					else
						# puts "&nbsp;&nbsp;&nbsp;&nbsp;match:<strong>" + job.children.text + "</strong><br />"
					   puts "<tr>"
					   puts "<td>" + location.children.text + "</td>"
					   puts "<td><a href='" + site + job.attributes["href"].value + "'>" + job.children.text + "</a></td>"
					   puts "<td><a href='" + site + company.attributes["href"].value + "'>" + company.children.text + "</a></td>"
					   puts "</tr>"
					end
				end
			# puts doc.css('td a')[0 + j * 4].children.text + "<br />"
			# puts doc.css('td a')[1 + j * 4].children.text + "<br />"
			# puts doc.css('td a')[3 + j * 4].children.text + "<br />"
		end 
		j = j + 1
		break if (3 + j * 1) > doc.css('td a').size
	end
i = i + 1
end
puts "</table>"