require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:one)
  end

  test "Creating a new quote" do
    # When we visit the index page
    # We expect to see the word "Quotes" in h1
    visit quotes_url
    assert_selector "h1", text: "Quotes"

    # When we click on a button/link with "New Quote"
    # We expect to be redirected to a page where an h1 with "New Quote"
    click_on "New Quote"
    assert_selector "h1", text: "New Quote"

    # When we fill in the Name input field with "Capybara test quote!"
    # And click on "Create Quote"
    # We expect to be redirected to the index page
    # We also expect to see the new quote added to the index list of quotes
    fill_in "Name", with: "Capybara test quote!"
    click_on "Create Quote"
    assert_selector "h1", text: "Quotes"
    assert_text "Capybara test quote!"
  end

  test "Showing a quote" do
    visit quotes_url
    click_link @quote.name

    assert_text @quote.name
  end

  test "Updating a quote" do
    visit quotes_url

    click_on "Edit", match: :first

    assert_text "Edit Quote"
    fill_in "Name", with: "Updated quote!"
    click_on "Update Quote"

    assert_selector "h1", text: "Quotes"
    assert_text "Updated quote!"
  end

  test "Destroying a quote" do
    visit quotes_url
    assert_text @quote.name

    click_on "Delete", match: :first
    assert_no_text @quote.name
  end
end
