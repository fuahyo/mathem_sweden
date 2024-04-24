#require './lib/headers'

idk = "bef9fcf1d4a491d2156853d1b78d9b742c6a1c01" #don't know what this is, but always need update

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}