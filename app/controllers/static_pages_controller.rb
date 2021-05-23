class StaticPagesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :search
  def home
  end

  def help
  end

  def privacy
  end

  def term
  end

  def about
  end

  def language
  end

  def search
    @user = current_user
    @search = Test.ransack(params[:q])
    @search_tests = @search.result(distinct: true)
  end

  def searchresult
    @user = current_user
    @search = Test.search(params[:q])
    @search_tests = @search.result.paginate(page: params[:page])
    # (distinct: true)
  end
end
