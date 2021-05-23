require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  include ActiveJob::TestHelper

  scenario "ユーザーはサインアップに成功する" do
    visit root_path
    click_link "⇨新しくユーザー登録される方はこちらへ"

    perform_enqueued_jobs do
      expect do
        fill_in "Name",          with: "Example"
        fill_in "Email",         with: "test@example.com"
        fill_in "Password",      with: "test123"
        fill_in "Confirmation",  with: "test123"
        click_button "Create my account"
      end.to change(User, :count).by(1)

      # expect(page).to have_content "アカウント有効化メールを送信しました。"
      expect(current_path).to eq root_path
    end

    # 以下はアカウント有効化メールのテストです
    # 詳細なテストは後で追加します
    mail = ActionMailer::Base.deliveries.last

    aggregate_failures do
      expect(mail.to).to eq ["test@example.com"]
      expect(mail.from).to eq ["noreply@example.com"]
      expect(mail.subject).to eq "Account activation"
    end
  end
end
