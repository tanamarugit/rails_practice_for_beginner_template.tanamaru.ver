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

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = '質問を更新しました。'
      render :edit
    else
      flash.now[:danger] = '失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path flash[:notice] = '質問を削除しました。'
  end

  def solved
    @questions = Question.where(solved_check: true)
    render :index
  end

  def unsolved
    @questions = Question.where(solved_check: false)
    render :index
  end

  def solve
    @question = Question.find(params[:id])
    @question.update!(solved_check: true)
    redirect_to question_path(@question), notice: '解決済みにしました。'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body )
  end
end
