class AnswersController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build(answer_params)
    @answer.save
    # redirect_to question_path(@answer.question)
  end

  def update
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.update answer_params
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
