class TestedsController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
    @user = current_user
  end

  def show
    @user = current_user
    @answers = Answer.where(tested_id: @user.id)
    @questions = []
    @answers.each do |answer|
      @questions = @questions.push(Question.find(answer.question_id))
    end
    @tests = []
    @questions.each do |question|
      @tests = @tests.push(Test.find(question.test_id))
    end
    @tests = @tests.uniq
  end

  def edit
  end

  def destroy
  end
end
