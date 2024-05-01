#require './lib/headers'

idk = "8bc45263c419bc1b5c428745f8166b4800813e3d" #don't know what this is, but always need update

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}