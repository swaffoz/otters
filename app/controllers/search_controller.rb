class SearchController < ApplicationController
  def show
    @articles = Article.search(params[:search])
  end
end
