#require './lib/headers'

json = JSON.parse(content)

categories = json['pageProps']['dehydratedState']['queries'].first['state']['data']['blocks'].detect{|i| i['id'] == "All categories"}['items']
raise "empty categories" if categories.nil? || categories.empty?

categories.each do |category|
    cat = category['data']

    cat_id = cat['id'].to_s
    cat_name = cat['title']
    cat_slug = cat['target']['uri'].split("/").last

    url = "https://www.mathem.se/_next/data/dea2c15da15af05b352b732c61bdef4559fb0118/se/categories/#{cat_slug}.json?site=se&primaryCategorySlug=#{cat_slug}"

    pages << {
        page_type: "subcategories",
        url: url,
        priority: 100,
        vars: {
            "cat_id" => cat_id,
            "cat_name" => cat_name,
            "cat_slug" => cat_slug,
        }
    }
end