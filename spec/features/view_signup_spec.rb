require 'rails_helper'

RSpec.feature "新規登録" do
  describe "新規登録ページ" do
    background do
      visit signup_path
    end

    it "新規登録ページにSign upと表示されていること" do
      expect(page).to have_content "Sign up"
    end
  end
end
