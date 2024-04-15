#require './lib/headers'

idk = "c62c5088219c98093eb6d1af72878d98f4d57d78" #don't know what this is, but always need update

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/#{idk}/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
	vars: {
		idk: idk,
	}
}