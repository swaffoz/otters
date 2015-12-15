## This controller only handles showing articles and the feed.
class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order('created_at DESC, updated_at DESC').first(3)
  end

  def archives
    page_size = 50

    @articles = Article.all.order('created_at DESC, updated_at DESC')
    @number_of_pages = (1.0 * @articles.count / page_size).ceil.abs
    @page_number = archive_page_number

    start = page_size * @page_number

    @articles.to_a.slice!(start, page_size) if @page_number < @number_of_pages
  end

  def colophon
  end

  def show
    @article = Article.friendly.find(params[:id])
  end

  def feed
    @articles = Article.order('created_at DESC, updated_at DESC')

    respond_to do |format|
      format.html
      format.rss { render layout: false }
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def archive_page_number
    params[:page].nil? ? 0 : params[:page].to_i
  end
end
