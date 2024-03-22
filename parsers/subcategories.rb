#require './lib/headers'

vars = page['vars']
json = JSON.parse(content)

subcategories = json['pageProps']['dehydratedState']['queries'].first['state']['data']['blocks'].select{|i| i['id'] =~ /product-category-section/i}#['items']
raise "empty subcategories" if subcategories.nil? || subcategories.empty?

subcategories.each do |subcategory|
    subcat = subcategory

    subcat_id = subcat['id'].split("-").last.to_s
    subcat_name = subcat['title']
    subcat_slug = subcat['button']['target']['uri'].split("/")[-2] rescue nil
    
    # "Frukt- och Grönsakskassar" don't have slug
    if subcat_slug.nil? && subcat_name != "Frukt- och Grönsakskassar"
        raise "please check"
    end

    url = "https://www.mathem.se/tienda-web-api/v1/section-listing/categories/#{subcat_id}/#{subcat_id}/?cursor=1&sort=default&filters=&size=24"

    pages << {
        page_type: "listings",
        url: url,
        priority: 90,
        vars: vars.merge(
            "subcat_id" => subcat_id,
            "subcat_name" => subcat_name,
            "subcat_slug" => subcat_slug,
            "page_number" => 1,
        )
    }
end