=begin
#require './lib/headers'

#store_id = 10
store_id = 23

pages << {
	page_type: "categories",
	url: "https://api.mathem.io/ecom-navigation/noauth/v3/menu/#{store_id}",
	#headers: ReqHeaders::HEADERS,
	vars: {
		store_id: store_id,
	}
}
=end

pages << {
	page_type: "categories",
	url: "https://www.mathem.se/_next/data/dea2c15da15af05b352b732c61bdef4559fb0118/se/products.json?site=se",
	#headers: ReqHeaders::HEADERS,
}