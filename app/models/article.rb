class Article < ActiveRecord::Base
	validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
	validates :text, presence: true
	
	def self.search(query)
		where("title like ? or text like ?", "%#{query}%", "%#{query}%")
	end
end
