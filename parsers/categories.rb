require './lib/headers'

json = JSON.parse(content)


categories = json["categories"]

categories.each do |cat|
    cat_id = cat["id"]
    cat_name = cat["title"]

    prod_count = cat["productCount"]

    url = "https://api.mathem.io/product-search/noauth/search/products/10/categorytag/#{cat_id}?size=#{prod_count}&index=0&storeId=10&badges=&brands=&categories=&supplier=&shop=&searchType=category&sortTerm=popular&sortOrder=desc"

    pages << {
        page_type: "listings",
        url: url,
        vars: {
            cat_id: cat_id,
            cat_name: cat_name,
            prod_count: prod_count,
        },
    }
end