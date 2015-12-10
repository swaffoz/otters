class RemoveIsPublishedFromArticles < ActiveRecord::Migration
  def change
    remove_column :articles, :is_published, :boolean
  end
end
