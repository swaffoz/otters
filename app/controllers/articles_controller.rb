## This controller only handles showing articles and the feed.
class ArticlesController < ApplicationController
  def index
    @articles = Rails.cache.fetch("#{cache_key}/current") do
      Article.all.order('created_at DESC, updated_at DESC').first(3)
    end
  end

  def archives
    page_size = 50

    @number_of_pages = (1.0 * Article.count / page_size).ceil.abs

    @page_number = archive_page_number(@number_of_pages)

    @articles = Rails.cache.fetch("#{cache_key}/archives") do
      Article.all.order('created_at DESC').to_a.slice(page_size * @page_number,
                                                      page_size)
    end
  end

  def colophon
  end

  def show
    @article = Rails.cache.fetch("#{cache_key}/#{params[:id]}") do
      Article.friendly.find(params[:id])
    end
  end

  def feed
    @articles = Rails.cache.fetch("#{cache_key}/feed") do
      Article.all.order('created_at DESC, updated_at DESC')
    end

    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def archive_page_number(number_of_pages)
    page_number = params[:page].nil? ? 1 : params[:page].to_i.abs
    page_number = page_number > 0 ? page_number : 1
    [number_of_pages, page_number].min
  end

  def cache_key
    count = Article.count
    max_updated_at = Article.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "articles/all-#{count}-#{max_updated_at}"
  end
end
