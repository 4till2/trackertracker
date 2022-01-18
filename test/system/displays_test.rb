require "application_system_test_case"

class DisplaysTest < ApplicationSystemTestCase
  setup do
    @display = displays(:one)
  end

  test "visiting the index" do
    visit displays_url
    assert_selector "h1", text: "Displays"
  end

  test "should create display" do
    visit displays_url
    click_on "New display"

    fill_in "Dashboard", with: @display.dashboard_id
    fill_in "Type", with: @display.type
    click_on "Create Display"

    assert_text "Display was successfully created"
    click_on "Back"
  end

  test "should update Display" do
    visit display_url(@display)
    click_on "Edit this display", match: :first

    fill_in "Dashboard", with: @display.dashboard_id
    fill_in "Type", with: @display.type
    click_on "Update Display"

    assert_text "Display was successfully updated"
    click_on "Back"
  end

  test "should destroy Display" do
    visit display_url(@display)
    click_on "Destroy this display", match: :first

    assert_text "Display was successfully destroyed"
  end
end
