#require './lib/headers'

json = JSON.parse(content)
vars = page["vars"]
store_id = vars["store_id"]

categories = json["categories"]

categories.each do |cat|
    cat_id = cat["id"]
    cat_name = cat["title"]

    url = "https://api.mathem.io/product-search/noauth/search/products/#{store_id}/categorytag/#{cat_id}?size=1000&index=0&storeId=#{store_id}&badges=&brands=&categories=&supplier=&shop=&searchType=category&sortTerm=popular&sortOrder=desc"

    pages << {
        page_type: "listings",
        url: url,
        priority: 100,
        vars: vars.merge(
            "cat_id" => cat_id,
            "cat_name" => cat_name,
            "page_number" => 1,
        )
    }
end