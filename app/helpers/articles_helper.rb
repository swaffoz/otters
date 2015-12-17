## This is the articles helper. It only keeps the cache key for the views.
module ArticlesHelper
  def cache_key_for_articles
    count = Article.count
    max_updated_at = Article.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "articles/all-#{count}-#{max_updated_at}"
  end
end
