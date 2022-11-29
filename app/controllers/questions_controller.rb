class QuestionsController < ApplicationController
  def index
    @questions = Question.all
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params.merge(user_id: current_user.id))
    if @question.save
      redirect_to questions_path, notice: '質問を作成しました。'
    else
      flash.now[:alert] = "質問の作成に失敗しました。"
      render :action => :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, )
  end
end
