#require './lib/headers'

html = Nokogiri.HTML(content)
script_text = html.at_css('body > script#__NEXT_DATA__').text.strip
File.open("jobs123.json","w") do |f|
    f.write(JSON.pretty_generate(script_text))
end
json = JSON.parse(script_text)
File.open("jobs1234.json","w") do |f|
    f.write(JSON.pretty_generate(json))
end


build_id = json['buildId']

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{build_id}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		build_id: build_id,
	}
}