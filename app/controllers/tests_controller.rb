class TestsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @tests = Test.paginate(page: params[:page])
  end

  # 自分が作ったテストの一覧
  def my_index
    @user = current_user
    @mytests = Test.where(user_id: @user.id).paginate(page: params[:page])
  end

  # テストの受験
  def show
    @user = User.find_by(id: params[:user_id])
    @test = Test.find(params[:id])
    @first_question = @test.questions.first
    @questions = Question.where(test_id: @test.id)
    @answer = Answer.new
  end

  def new
    @user = current_user
    @test = Test.new
    @mytests = Test.where(user_id: @user.id).paginate(page: params[:page])
  end

  def create
    @test = current_user.tests.build(test_params)
    if @test.save
      flash[:success] = "Test created!"
      redirect_to mytests_path
    else
      @tests = []
      render mytests_path
    end
  end

  def edit
    @user = current_user
    @test = Test.find(params[:id])
  end

  def update
    @test = Test.find(params[:id])
    if @test.update_attributes(test_params)
      flash[:success] = "Test updated"
      redirect_to mytests_path
    else
      render 'edit'
    end
  end

  def destroy
    @test.destroy
    flash[:seccess] = "Test deleted"
    redirect_to request.referrer || root_url
  end

  private

  def test_params
    params.require(:test).permit(:subject, :title, :tested_id, :user_id)
  end

  def correct_user
    @test = current_user.tests.find_by(id: params[:id])
    redirect_to(root_url) if @test.nil?
  end
end
