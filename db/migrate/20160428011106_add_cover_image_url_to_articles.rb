class AddCoverImageUrlToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :cover_image_url, :string
  end
end
