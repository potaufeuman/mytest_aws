require 'rails_helper'

RSpec.feature 'ログイン' do
  background do
    User.create!(name:  "Example User",
                 email: "example@fortune.org",
                 password:              "foobar",
                 password_confirmation: "foobar",
                 admin:     false,
                 activated: true,
                 activated_at: Time.zone.now)
  end
  scenario 'ログインする' do
    visit root_path
    fill_in "Email", with: "example@fortune.org"
    fill_in "Password", with: "foobar"
    click_button "Log in"
    expect(page).to have_content "Create"
  end
end
