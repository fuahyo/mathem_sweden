info = page["vars"]["info"]
html = Nokogiri.HTML(content)

info["_collection"] = "products"
info["_id"] = info["competitor_product_id"]
info["scraped_at_timestamp"] = Time.now.strftime('%Y-%m-%d %H:%M:%S')
#info["description"] = html.at_css("mathem-product-details-accordion p").text.strip rescue nil
info["description"] = html.at_css("mathem-product-details-accordion").text.strip rescue nil

info["is_promoted"] = false
info["type_of_promotion"] = nil
info["promo_attributes"] = nil

promo = html.at_css(".product .product-overlay .splash-container").text.strip rescue nil
if promo
    unless promo =~ /Snart i lager/i
        info["is_promoted"] = true
        info["type_of_promotion"] = "badge"
        info["promo_attributes"] = JSON.generate({
            "promo_detail" => "'#{promo}'",
        })
    end
end

outputs << info