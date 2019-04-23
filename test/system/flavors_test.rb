require "application_system_test_case"

class FalvorsTest < ApplicationSystemTestCase
 
  
  
  setup do
    @falvor = falvors(:one)
  end

  test "visiting the index" do
    visit falvors_url
    assert_selector "h1", text: "Falvors"
  end

  test "creating a Falvor" do
    visit falvors_url
    click_on "New Falvor"

    fill_in "Active", with: @falvor.active
    fill_in "Name", with: @falvor.name
    click_on "Create Falvor"

    assert_text "Falvor was successfully created"
    click_on "Back"
  end

  test "updating a Falvor" do
    visit falvors_url
    click_on "Edit", match: :first

    fill_in "Active", with: @falvor.active
    fill_in "Name", with: @falvor.name
    click_on "Update Falvor"

    assert_text "Falvor was successfully updated"
    click_on "Back"
  end

  test "destroying a Falvor" do
    visit falvors_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Falvor was successfully destroyed"
  end
end
