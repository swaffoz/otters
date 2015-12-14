## This controller only handles showing articles and the feed.
class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order('created_at DESC, updated_at DESC').first(3)
  end

  def archives
    @articles = Article.all.order('created_at DESC, updated_at DESC')
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
