#require './lib/headers'

idk = "4b6065a2dc3cf63c987bede1d1038ed29855e4b2" #don't know what this is, but always need update

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}