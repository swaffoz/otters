class AddIsPublishedToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :is_published, :boolean
  end
end
