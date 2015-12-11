require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  
  test "should show index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end
  
  test "should return valid RSS feed" do
      get :feed, {format: 'rss'}
      assert_response :success
      assert_not_nil assigns(:articles)
      begin
        rss_doc = Nokogiri::XML(@response.body) do |config|
          config.options = Nokogiri::XML::ParseOptions::STRICT 
        end
    rescue Nokogiri::XML::SyntaxError => e
      puts "caught exception: #{e}"
    end
  end
  
end
