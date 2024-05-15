#require './lib/headers'

idk = "f0cd8e68bd08433f1bad23a56af8c38f63c8ceb0" #don't know what this is, but always need update

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}