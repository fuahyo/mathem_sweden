#require './lib/headers'

idk = "8a226f4b7c771fb532b30d4e8131e877f3ceb953" #don't know what this is

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}