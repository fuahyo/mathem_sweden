def Refetch_Page(page)
    refetch_count = page["vars"]["refetch_count"] || 0

    unless refetch_count > 10
        refetch_count += 1

        pages << {
            page_type: "product",
            url: page["url"],
            http2: true,
            fetch_type: "browser",
            driver: {
                name: "refetch_#{refetch_count}",
                #"code": "await sleep(3000)",
                enable_images: false,
                stealth: false,
                goto_options: {
                    timeout: 0,
                    waitUntil: "networkidle0",
                },
            },
            headers: {
                "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:105.0) Gecko/20100101 Firefox/105.0",
            },
            vars: page["vars"].merge("refetch_count" => refetch_count)
        }
    else
        raise "max refetch reached"
    end
end


info = page["vars"]["info"]
html = Nokogiri.HTML(content)


if content.nil? || html.at_css("h1").nil?
    #raise "failed page, please refetch"
    Refetch_Page(page)
else
    info["_collection"] = "products"
    info["_id"] = info["competitor_product_id"]
    #info["description"] = html.at_css("mathem-product-details-accordion p").text.strip rescue nil
    info["description"] = html.at_css("mathem-product-details-accordion").text.strip rescue nil

    info["is_promoted"] = false
    info["type_of_promotion"] = nil
    info["promo_attributes"] = nil
    info['scraped_at_timestamp'] = (ENV['reparse'] == "1" ? (Time.parse(page['fetched_at']) + 1).strftime('%Y-%m-%d %H:%M:%S') : Time.parse(page['fetched_at']).strftime('%Y-%m-%d %H:%M:%S'))

    promo = html.at_css(".product .product-overlay .splash-container").text.strip rescue nil
    if promo
        unless promo =~ /Snart\s?i\s?lager/i
            info["is_promoted"] = true
            info["type_of_promotion"] = "badge"
            info["promo_attributes"] = JSON.generate({
                "promo_detail" => "'#{promo}'",
            })
        end
    end

    outputs << info
end