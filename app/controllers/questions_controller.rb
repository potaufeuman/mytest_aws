class QuestionsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  include QuestionsHelper

  def new
    @user = current_user
    @test = Test.find(params[:test_id])
    @question = Question.new
  end

  def create
    @test = Test.find(params[:test_id])
    @question = @test.questions.build(question_params)
    if @question.save
      flash[:success] = "Question created!"
      redirect_to request.referrer || mytests_path
    else
      redirect_to request.referrer || mytests_path
    end
  end

  def edit
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = "Question deleted"
    redirect_to new_test_question_path || mytests_path
  end

  def answerring
    @user = current_user
    @test = Test.find(params[:test_id])
    @question = @test.questions.find(params[:id])
    answer_selects(@question)
    now_answer(@test)  # 回答すると、次の質問にジャンプする。AnswersHelper参照。
    @answers = []
    (@ia + 1).times do
      @answer = Answer.new
      @answers = @answers.push(@answer)
    end
  end

  def post_answerring
    @user = current_user
    @test = Test.find(params[:test_id])
    @question = @test.questions.find(params[:id])
    @answer = @question.answers.build(answer_params)
    answer_selects(@question)
    now_answer(@test)  # 回答すると、次の質問にジャンプする。AnswersHelper参照。
    if @answer.save
      if @next_question.nil?
        tested_id = @user.id
        redirect_to tested_test_answers_path(tested_id, @test.id) # 採点ページにジャンプする。
      else
        redirect_to answerring_test_question_path(@test, @next_question.id)
      end
    else
      redirect_to request.referrer || mytests_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:test_id, :Q, :correct_A, :point, :picture)
  end

  def answer_params
    params.require(:answer).permit(:tested_id, :select_A, :select_id)
  end
end
