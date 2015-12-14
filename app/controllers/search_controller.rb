### This controller handles searching through the articles and displaying them
class SearchController < ApplicationController
  def show
    @search = params[:search]
    @articles = Article.search(@search).order('created_at DESC')
  end
end
