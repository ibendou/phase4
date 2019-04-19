require 'test_helper'

class FalvorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @falvor = falvors(:one)
  end

  test "should get index" do
    get falvors_url
    assert_response :success
  end

  test "should get new" do
    get new_falvor_url
    assert_response :success
  end

  test "should create falvor" do
    assert_difference('Falvor.count') do
      post falvors_url, params: { falvor: { active: @falvor.active, name: @falvor.name } }
    end

    assert_redirected_to falvor_url(Falvor.last)
  end

  test "should show falvor" do
    get falvor_url(@falvor)
    assert_response :success
  end

  test "should get edit" do
    get edit_falvor_url(@falvor)
    assert_response :success
  end

  test "should update falvor" do
    patch falvor_url(@falvor), params: { falvor: { active: @falvor.active, name: @falvor.name } }
    assert_redirected_to falvor_url(@falvor)
  end

  test "should destroy falvor" do
    assert_difference('Falvor.count', -1) do
      delete falvor_url(@falvor)
    end

    assert_redirected_to falvors_url
  end
end
