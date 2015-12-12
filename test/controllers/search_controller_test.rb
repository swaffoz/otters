require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  test 'should assign search results' do
    get :show, search: 'some search terms'
    assert_response :success
    assert_not_nil assigns(:articles)
  end
end
