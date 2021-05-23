class AnswersController < ApplicationController
  before_action :logged_in_user
  include AnswersHelper

  def index
    @user = current_user
    @test = Test.find(params[:test_id])
    answers_show(@test)
    # @question_A = Question.find(answer.question_id)
  end

  def show
    @user = current_user
    @test = Test.find(params[:test_id])
    answers_show(@test)
  end

  def new
  end

  def create
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    flash[:success] = "Answer deleted"
    redirect_to request.referrer || mytests_path
  end

  private

  def answer_params
    params.require(:answer).permit(:test_id, :tested_id, :select_A, :select_id)
  end
end
