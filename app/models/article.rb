class Article < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
	validates :text, presence: true
	
	def self.search(query)
		where("title like ? or text like ?", "%#{query}%", "%#{query}%")
	end
	
	def feed 
			@articles = Article.order('created_at DESC, updated_at DESC')
			respond_to do |format|
				format.html
				format.rss { render :layout => false }
			end
		end
end
