### This controller handles searching through the articles and displaying them
class SearchController < ApplicationController
  def show
    @articles = Article.search(params[:search])
  end
end
