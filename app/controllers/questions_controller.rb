class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_model, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.order(:title)
  end

  def show
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to @question, success: 'Вопрос успешно создан'
    else
      flash.now[:danger] = 'Ошибка, вопрос не удалось создать'
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to @question, success: 'Вопрос успешно изменен'
    else
      flash.now[:danger] = 'Ошибка, вопрос не удалось изменить'
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, success: 'Вопрос удален'
  end
  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def load_model
    @question = Question.find(params[:id])
  end
end
