class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_locale

  # リンクの多言語化に対応する
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def locale
    @locale ||= params[:locale] || I18n.default_locale
  end

  # 全リンクにlocale情報をセットする
  # def default_url_options(options={})
  #   { locale: I18n.locale }.merge options
  #   # options.merge(locale: @locale)
  # end
  def default_url_options
    { locale: I18n.locale }
  end

  def search
    @user = current_user
    @search = Test.ransack(params[:q])
    @search_tests = @search.result
    # (distinct: true)
  end

  private

  # ユーザーのログインを確認する
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
