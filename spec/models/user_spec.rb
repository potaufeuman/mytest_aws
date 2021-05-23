require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  describe User do
    it "有効なファクトリを持つこと" do
      expect(user).to be_valid
    end
  end

  # Shoulda Matchers を使用
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_length_of(:name).is_at_most(50) }
  it { is_expected.to validate_presence_of :email }
  # it { is_expected.to validate_uniqueness_of(:email).case_insensitive } ・・・(*)
  it { is_expected.to validate_length_of(:email).is_at_most(255) }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  it "重複したメールアドレス（大小文字区別なし）なら無効な状態であること" do
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "Aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  describe "メールアドレスの有効性" do
    scenario "無効なメールアドレスの場合" do
      invalid_addresses = %w(
        user@example,com user_at_foo.org user.name@example.
        foo@bar_baz.com foo@bar+baz.com
      )
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).not_to be_valid
      end
    end

    scenario "有効なメールアドレスの場合" do
      valid_addresses = %w(user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn)
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end
  end

  describe "パスワード確認が一致すること" do
    scenario "一致する場合" do
      user = FactoryBot.build(:user, password: "password", password_confirmation: "password")
      expect(user).to be_valid
    end

    scenario "一致しない場合" do
      user = FactoryBot.build(:user, password: "password", password_confirmation: "different")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end
  end
end
