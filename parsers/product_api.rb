require './lib/headers'
require './lib/helpers'

vars = page['vars']
current_page = vars['page_number']
rank = vars['rank']
json = JSON.parse(content)

prod_id = json['id'].to_s
prod_name = json['name']

name_extra = json['name_extra']

is_private_label = nil
brand = json['brand']
unless brand.empty?
    is_private_label = (brand =~ /mathem/i) ? false : true
end

categories = json['categories'].first['parents']
last_subcat = json['categories'].first.select{|k, v| ['id', 'name', 'uri'].include?(k)}
categories.append(last_subcat)

cat_id = categories.first['id'].to_s
cat_name = categories.first['name']

subcat = nil
if categories.count > 1
    subcat = categories[1..-1].map{|i| i['name']}.join(" > ")
end

customer_price_lc = json['gross_price'].to_f
base_price_lc = json['discount']['undiscounted_gross_price'].to_f rescue customer_price_lc
has_discount = customer_price_lc < base_price_lc
discount_percentage = has_discount ? GetFunc::get_discount(base_price_lc, customer_price_lc) : nil

prod_pieces = GetFunc::get_pieces(prod_name)
if prod_pieces == 1
    prod_pieces = GetFunc::get_pieces(name_extra)
end

uom = GetFunc::get_uom(prod_name)
size_std = uom[:size]
size_unit_std = uom[:unit]
if size_std.nil? && size_unit_std.nil?
    uom = GetFunc::get_uom(name_extra)
    size_std = uom[:size]
    size_unit_std = uom[:unit]
end

description = json['detailed_info']['local'].first['short_description']
img_url = json['images'].first['thumbnail']['url']
barcode = prod_id
is_available = json['availability']['is_available']

#
is_promoted = false
type_of_promotion = nil
promo_attributes = nil

promos_arr = []
promos = json['promotions']
promos.each do |promo|
    promos_arr.append("'#{promo['title']}'")
end

unless promos_arr.empty?
    is_promoted = true
    type_of_promotion = "badge"
    promo_attributes = JSON.generate({
        "promo_details" => promos_arr.join(", "),
    })
end
#

#total_reviews = prod["rating"]["votes"].to_i rescue nil
#avg_rating = prod["rating"]["avgRating"].to_f rescue nil
#reviews = JSON.generate({
#    "num_total_reviews" => total_reviews,
#    "avg_rating" => avg_rating,
#})
reviews = nil


item_attributes = nil
item_attributes_check = json['client_classifiers']
if item_attributes_check.count > 0
    dietaries = item_attributes_check.map{|i| "'#{i['name'].strip}'"}.join(", ")
    item_attributes = JSON.generate({
        "dietary attributes" => dietaries,
    })
end
#labels = prod["preferences"]["labels"].map{|l| "'#{l["name"]}'"}.join(", ")
#item_attributes = JSON.generate({
#    "dietary" => dietary,
#    "labels" => labels,
#})

#item_identifiers = JSON.generate({
#	"barcode" => "'#{prod["gtin"]}'",
#})
item_identifiers = nil

country_of_origin = json['detailed_info']['local'].first['contents_table']['rows'].detect{|i| i['key'] == "Ursprungsregion"}['value'] rescue nil

url = json['front_url']

outputs << {
    _collection: "products",
    _id: prod_id,
    competitor_name: "MATHEM",
    competitor_type: "dmart",
    store_name: "MATHEM",
    store_id: nil,
    country_iso: "SE",
    language: "SWE",
    currency_code_lc: "SEK",
    #scraped_at_timestamp: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
    scraped_at_timestamp: ((ENV['needs_reparse'] == 1 || ENV['needs_reparse'] == "1") ? (Time.parse(page['fetched_at']) + 1).strftime('%Y-%m-%d %H:%M:%S') : Time.parse(page['fetched_at']).strftime('%Y-%m-%d %H:%M:%S')),
    ###
    competitor_product_id: prod_id,
    name: prod_name,
    brand: brand,
    category_id: cat_id,
    category: cat_name,
    sub_category: subcat,
    customer_price_lc: customer_price_lc,
    base_price_lc: base_price_lc,
    has_discount: has_discount,
    discount_percentage: discount_percentage,
    rank_in_listing: rank,
    page_number: current_page,
    product_pieces: prod_pieces,
    size_std: size_std,
    size_unit_std: size_unit_std,
    description: description,
    img_url: img_url,
    barcode: barcode,
    sku: nil,
    url: url,
    is_available: is_available,
    crawled_source: "WEB",
    is_promoted: is_promoted,
    type_of_promotion: type_of_promotion,
    promo_attributes: promo_attributes,
    is_private_label: is_private_label,
    latitude: nil,
    longitude: nil,
    reviews: reviews,
    store_reviews: nil,
    item_attributes: item_attributes,
    item_identifiers: item_identifiers,
    country_of_origin: country_of_origin,
    variants: nil,
}


=begin
pages << {
    page_type: "product_html",
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
=end