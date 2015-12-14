## This controller only handles showing articles and the feed.
class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order('created_at DESC, updated_at DESC').first(3)
  end

  def archives
    page_size = 50
    @page_number = params[:page].nil? ? 0 : params[:page].to_i
    @number_of_pages = (1.0 * Article.all.count / page_size).ceil

    lower_bound = page_size * @page_number.to_i
    upper_bound = page_size * (@page_number.to_i + 1)

    if @page_number < @number_of_pages
      range = lower_bound...upper_bound
      @articles = Article.all.order('created_at DESC, updated_at DESC')[range]
    else
      @page_number = 1
      @articles = Article.all.order('created_at DESC, updated_at DESC')
    end
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
end
