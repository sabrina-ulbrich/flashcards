require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create card" do
    assert_difference('Card.count') do
      post :create, :card => { :backpage_image => @card.backpage_image, :backpage_text => @card.backpage_text, :category => @card.category, :frontpage_image => @card.frontpage_image, :frontpage_text => @card.frontpage_text, :known => @card.known }
    end

    assert_redirected_to card_path(assigns(:card))
  end

  test "should show card" do
    get :show, :id => @card
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @card
    assert_response :success
  end

  test "should update card" do
    put :update, :id => @card, :card => { :backpage_image => @card.backpage_image, :backpage_text => @card.backpage_text, :category => @card.category, :frontpage_image => @card.frontpage_image, :frontpage_text => @card.frontpage_text, :known => @card.known }
    assert_redirected_to card_path(assigns(:card))
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete :destroy, :id => @card
    end

    assert_redirected_to cards_path
  end
end
