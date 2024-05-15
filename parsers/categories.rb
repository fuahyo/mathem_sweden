#require './lib/headers'

vars = page['vars']
build_id = vars['build_id']
json = JSON.parse(content)

categories = json['pageProps']['dehydratedState']['queries'].first['state']['data']['blocks'].detect{|i| i['id'] == "All categories"}['items']
raise "empty categories" if categories.nil? || categories.empty?

categories.each do |category|
    cat = category['data']

    cat_id = cat['id'].to_s
    cat_name = cat['title']
    cat_slug = cat['target']['uri'].split("/").last

    url = "https://www.mathem.se/_next/data/#{build_id}/se/categories/#{cat_slug}.json?site=se&primaryCategorySlug=#{cat_slug}"

    pages << {
        page_type: "subcategories",
        url: url,
        priority: 100,
        vars: vars.merge(
            "cat_id" => cat_id,
            "cat_name" => cat_name,
            "cat_slug" => cat_slug,
        )
    }
end