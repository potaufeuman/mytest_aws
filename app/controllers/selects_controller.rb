class SelectsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def new
    @user = current_user
    @test = Test.find(params[:test_id])
    @question = @test.questions.find(params[:question_id])
    @select = Select.new
  end

  def create
    @test = Test.find(params[:test_id])
    @question = @test.questions.find(params[:question_id])
    @select = @question.selects.build(select_params)
    if @select.save
      flash[:success] = "Select created!"
      redirect_to request.referrer || mytests_path
    else
      redirect_to request.referrer || mytests_path
    end
  end

  def edit
  end

  def destroy
    @select = Select.find(params[:id])
    @select.destroy
    flash[:success] = "Select deleted"
    redirect_to request.referrer || mytests_path
  end

  private

  def select_params
    params.require(:select).permit(:content, :judge)
  end
end
