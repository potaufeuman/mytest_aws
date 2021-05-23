require 'rails_helper'

RSpec.feature 'タイトル' do
  specify 'タイトル内容の表示' do
    visit root_path
    expect(page).to have_title 'Top | MyTest'
  end
end

RSpec.feature 'ログイン' do
  background do
    User.create!(name: "Example User",
                 email: "example@fortune.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: false,
                 activated: true,
                 activated_at: Time.zone.now)
  end
  scenario 'ログインする' do
    visit root_path
    fill_in "Email", with: "example@fortune.org"
    fill_in "Password", with: "foobar"
    click_button "ログイン"
    expect(page).to have_content "新規作成"
  end
end
