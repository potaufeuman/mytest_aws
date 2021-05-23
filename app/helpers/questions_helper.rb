module QuestionsHelper
  def answers_show(test)
    @answers = []
    @questions = []
    @test.questions.each_with_index do |question, iq|
      @questions = @questions.push(question)
      question.answers.each_with_index do |answer, ia|
        @answers = @answers.push(answer)
      end
    end
  end

  def answer_selects(question)
    @selects = []
    question.selects.each_with_index do |select, ia|
      @selects = @selects.push(select)
      @ia = ia
    end
  end

  def now_answer(test)
    questions = []
    @test.questions.each_with_index do |question, i|
      questions.push(question)
      if question.id == params[:id].to_i
        @question_num = i + 1
      end
    end
    @next_question = questions[@question_num]
  end
end
