require 'rails_helper'

feature "Events" do

  scenario "User edits an event" do
    Event.create!(
      description: "My aweeesome event"
    )

    visit root_path
    expect(page).to have_content("My aweeesome event")
    click_on "edit"
    fill_in "Description", with: "My awesome event"
    click_on "Update Event"

    expect(page).to have_content("My awesome event")
    expect(page).to have_no_content("My aweeesome event")
  end

  scenario "User creates an event" do
    Event.create!(
      description: "SantaCon"
    )

    visit root_path
    expect(page).to have_content("SantaCon")
    click_on "New Event"
    fill_in "Description", with: "SantaCon2"
    click_on "Create Event"

    expect(page).to have_content("SantaCon")
    expect(page).to have_content("SantaCon2")
    expect(page.current_path).to eq(events_path)
  end

  scenario "listing events" do
    Event.create!(
      description: "Free Lunch",
    )

    Event.create!(
      description: "Hug Momo Hour",
    )

    Event.create!(
      description: "Ramen Festival",
    )

    visit root_path

    expect(page).to have_content("Free Lunch")
    expect(page).to have_content("Hug Momo Hour")
    expect(page).to have_content("Ramen Festival")
  end

  scenario "deleting events" do
    Event.create!(
      description: "Delete Me"
    )

    visit root_path
    click_on "delete"

    expect(page).to have_no_content("Delete Me")
    expect(page.current_path).to eq(events_path)
  end
end
