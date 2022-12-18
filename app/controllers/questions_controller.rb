class QuestionsController < ApplicationController
  def index
    @q = Question.ransack(params[:q])
    @questions = @q.result(distinct: true)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params.merge(user_id: current_user.id))
    if @question.save
      redirect_to questions_path, notice: '質問を作成しました。'
    else
      flash.now[:alert] = "質問の作成に失敗しました。"
      render :action => :new
    end
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end

  def update
    @question = current_user.questions.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = '質問を更新しました。'
      render :edit
    else
      flash.now[:danger] = 'ユーザー本人ではないため質問の更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @question = current_user.questions.find(params[:id])
    if @question.destroy
      redirect_to questions_path flash[:notice] = '質問を削除しました。'
    else
      flash.now[:danger] = 'ユーザー本人ではないため、質問の削除に失敗しました。'
      render :index
    end
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
    @question = current_user.questions.find(params[:id])
    @question.update!(solved_check: true)
    redirect_to question_path(@question), notice: '解決済みにしました。'
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  private

  def question_params
    params.require(:question).permit(:title, :body )
  end
end
