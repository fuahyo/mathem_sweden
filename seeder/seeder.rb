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