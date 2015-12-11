require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new
    article.text = "This is my text"
    assert_not article.save, "Saved the article without a title"
  end
  
  test "should not save srticle without text" do
    article = Article.new
    article.title = "My Title"
    assert_not article.save, "Saved the article without a text"
  end
  
  test "should not save two articles with same title" do
    article = Article.new
    article.title = "First Title"
    article.text = "First Text"
    article.save
    
    second_article = Article.new
    second_article.title = article.title
    second_article.text = "Second Text"
    
    assert_not second_article.save, "Saved two articles with the same title"
  end
end
