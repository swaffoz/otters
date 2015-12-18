## This is our Article class. It has a title, some text,
## and friendly id for url slugs. That's it!
class Article < ActiveRecord::Base
  extend FriendlyId

  validates :title, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :text, presence: true

  serialize :text
  friendly_id :title, use: :slugged

  def self.search(query)
    where('title like ? or text like ?', "%#{query}%", "%#{query}%")
  end
end
