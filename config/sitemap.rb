# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = Rails.application.secrets.app_url

SitemapGenerator::Sitemap.create do
  add '/', :changefreq => 'daily', :priority => 1.0
  add '/colophon', :changefreq => 'weekly'
  
  Article.find_each do |article|
    add article_path(article), 
        :lastmod => article.updated_at, 
        :changefreq => 'daily',
        :priority => 0.9
  end
end

SitemapGenerator::Sitemap.ping_search_engines
