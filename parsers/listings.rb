require './lib/headers'
require './lib/helpers'

PER_PAGE = 24
vars = page['vars']
current_page = vars['page_number']
json = JSON.parse(content)

# pagination
if current_page == 1
    prod_count = json['parent_sections'].detect{|i| i['active'] == true}['count']

    if prod_count > PER_PAGE
        total_page = (prod_count/PER_PAGE.to_f).ceil

        (2..total_page).each do |pn|        
            url = page["url"].gsub("cursor=1", "cursor=#{pn}")

            pages << {
                page_type: "listings",
                url: url,
                priority: 80,
                vars: vars.merge("page_number" => pn),
            }
        end
    end

    outputs << {
        _collection: "first_page",
        vars: vars,
        prod_count: prod_count,
    }
end


products = json['items'].map{|i| i['attributes']}
products.each_with_index do |prod, idx|
    rank = idx+1
    prod_id = prod['id']

=begin
    prod_name = prod["name"]
    is_private_label = nil
    brand = prod["brand"]
    unless brand.empty?
        is_private_label = (brand =~ /mathem/i) ? false : true
    end

    category_ancestry = prod["categoryAncestry"].reverse
    cat_id = category_ancestry[0]["id"]
    cat_name = category_ancestry[0]["name"]
    sub_category_arr = []
    sub_cat = category_ancestry[1..-1].map{|sc| sc["name"]}.join(" > ")### ini untuk mapping subcat

    base_price_lc = prod["price"]
    customer_price_lc = prod["discount"]["unitPrice"] rescue base_price_lc
    has_discount = customer_price_lc < base_price_lc
    discount_percentage = has_discount ? GetFunc::get_discount(base_price_lc, customer_price_lc) : nil

    prod_pieces = GetFunc::get_pieces(prod_name)

    uom = GetFunc::get_uom(prod_name)
	size_std = uom[:size]
	size_unit_std = uom[:unit]

    img_check = prod["images"]["ORIGINAL"] rescue nil
    img_url = img_check ? "https:#{img_check}" : nil
    is_available = !prod["stockInformation"]["outOfStock"] rescue false
    
    total_reviews = prod["rating"]["votes"].to_i rescue nil
    avg_rating = prod["rating"]["avgRating"].to_f rescue nil
    reviews = JSON.generate({
        "num_total_reviews" => total_reviews,
        "avg_rating" => avg_rating,
    })

    dietary = prod["preferences"]["dietary"].map{|d| "'#{d["name"]}'"}.join(", ")
    labels = prod["preferences"]["labels"].map{|l| "'#{l["name"]}'"}.join(", ")
    item_attributes = JSON.generate({
        "dietary" => dietary,
        "labels" => labels,
    })

    #item_identifiers = JSON.generate({
	#	"barcode" => "'#{prod["gtin"]}'",
	#})
    item_identifiers = nil

    origin = prod["origin"]["name"] rescue nil

    url = "https://www.mathem.se#{prod["url"]}"

    info = {
		#_collection: "product_list",
        #_id: product_id,
        competitor_name: "MATHEM",
        competitor_type: "dmart",
        store_name: prod["shops"][0]["name"],
        store_id: prod["shops"][0]["id"],
        country_iso: "SE",
        language: "SWE",
        currency_code_lc: "SEK",
        #scraped_at_timestamp: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
        ###
        competitor_product_id: prod_id,
        name: prod_name,
        brand: brand,
        category_id: cat_id,
        category: cat_name,
        sub_category: sub_cat,###
        customer_price_lc: customer_price_lc,
        base_price_lc: base_price_lc,
        has_discount: has_discount,
        discount_percentage: discount_percentage,
        rank_in_listing: rank,
        page_number: current_page,
        product_pieces: prod_pieces,
        size_std: size_std,
        size_unit_std: size_unit_std,
        #description: nil,
        img_url: img_url,
        barcode: prod["gtin"],
        sku: nil,
        url: url,
        is_available: is_available,
        crawled_source: "WEB",
        #is_promoted: false,
        #type_of_promotion: nil,
        #promo_attributes: nil,
        is_private_label: is_private_label,
        latitude: nil,
        longitude: nil,
        reviews: reviews,
        store_reviews: nil,
        item_attributes: item_attributes,
        item_identifiers: item_identifiers,
        country_of_origin: origin,
        variants: nil,
	}
=end
    url = "https://www.mathem.se/tienda-web-api/v1/products/#{prod_id}/"

    pages << {
        page_type: "product_api",
        url: url,
        http2: true,
        priority: 70,
        #fetch_type: "browser",
        #driver: {
        #    #"code": "await sleep(3000)",
        #    "enable_images": false,
        #    "stealth": false,
        #    "goto_options": {
        #        "timeout": 0,
        #        "waitUntil": "networkidle2",
        #    },
        #},
        #headers: ReqHeaders::HEADERS,
        #vars: vars.merge("info" => info),
        vars: vars.merge('rank' => rank)
    }
end