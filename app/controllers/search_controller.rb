class SearchController < ApplicationController
  def show
    @articles = Article.search(params[:search])
    
    # respond_to do |format|
    #   format.html {render show}
    # end
  end
end
