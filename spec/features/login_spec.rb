require 'rails_helper'

RSpec.feature "Login", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  # scenario "無効な情報ではログインに失敗すること" do
  #   visit root_path
  #   fill_in "Email", with: ""
  #   fill_in "Password", with: ""
  #   click_button "ログイン"
  #   expect(current_path).to eq root_path
  # end

  scenario "ログインに成功すること" do
    # valid_login(user) login_supportを読み込めないと使えない。
    visit root_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "ログイン"
    expect(current_path).to eq user_path(user)
    expect(page).not_to have_content "Welcome to MyTest!"
  end
end
