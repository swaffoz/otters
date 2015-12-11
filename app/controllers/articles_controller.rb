class ArticlesController < ApplicationController
	def index
		@articles = Article.all
	end

	def show
		@article = Article.friendly.find(params[:id])
	end
	
	def feed 
		@articles = Article.order('created_at DESC, updated_at DESC')
	
		respond_to do |format|
			format.html
			format.rss { render :layout => false }
		end
	end	
	
private
	def article_params
		params.require(:article).permit(:title, :text)
	end
end
