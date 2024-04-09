#require './lib/headers'

idk = "707ce1d8b165c826ef3954dfac5ea41c9f9b9b9b" #don't know what this is, but always need update

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}