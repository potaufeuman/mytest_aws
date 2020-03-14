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
  
  # # 他人が作ったテストの一覧 → users#show でOK
  # def another_index
  #   @user = User.find(params[:user_id])
  #   @tests = @user.tests.paginate(page: params[:page])
  # end
  
  # テストの受験
  def show
    @user = User.find_by(id: params[:user_id])
    # @tests = @user.tests.paginate(page: params[:page])
    @test = Test.find(params[:id])
  end
    
  def new
    @test = Test.new
  end
  
  def create
    @test = current_user.tests.build(test_params)
    if @test.save
      flash[:success] = "Test created!"
      redirect_to root_url
    else
      render root_url
    end
  end
  
  def edit
    
  end
  
  def update
    
  end

  def destroy
    @test.destroy
    flash[:seccess] = "Test deleted"
    redirect_to request.referrer || root_url
  end
  
  private
    def test_params
      params.require(:test).permit(:subject, :title)
    end
  
    def correct_user
      @test = current_user.tests.find_by(id: params[:id])
      redirect_to(root_url) if @test.nil?
    end
end
