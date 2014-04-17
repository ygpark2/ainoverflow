class QuestionsController < ApplicationController

  skip_before_filter :require_user , :only => [:new , :edit , :create , :update , :vote]
  after_filter :increment_total_views , :only => [:show]

  def index
    @questions = Question.paginate(:page => params[:page] , :per_page => 10 , :order => 'created_at DESC')
    @tags = Question.tag_counts_on(:tags)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    # @question.upvote_from current_user
    if @question.save
      flash[:notice] = t('flash.notice.question.create.valid')
      redirect_to questions_path
    else
      flash[:notice] = t('flash.notice.question.create.invalid')
      render 'new'
    end
  end
  
  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.all(:order => 'selected DESC')
    @link_questions = Question.tagged_with(@question.tag_list, :any => true)
  end

  def edit
    @question = current_user.questions.find(params[:id])
  end
  
  def update
    @question = current_user.questions.find(params[:id])
    if @question.update_attributes(params[:question])
      flash[:notice] = t('flash.notice.question.update.valid')
      redirect_to @question
    else
      flash[:notice] = t('flash.notice.question.update.invalid')
      render 'edit'
    end
  end

  def comment
    question = Question.find(params[:id])
    comment = question.comments.create
    comment.title = "question - " + params[:id]
    comment.comment = params[:body]
    comment.user_id = current_user
    if comment.save
      flash[:notice] = t('flash.notice.question.create.valid')
    else
      flash[:notice] = t('flash.notice.question.create.invalid')
    end
    respond_to do |format|
      format.html { redirect_to question_path(question)}
      format.json { render :json => comment }
    end
  end

  def vote
    question = Question.find(params[:id])
    if params[:vote].to_s.eql?("up")
      if question.upvote_from current_user, :vote_scope => 'rank', :vote_weight => 1
        flash[:notice] = t('flash.notice.question.vote.update')
      end
    else
      if question.downvote_from current_user, :vote_scope => 'rank', :vote_weight => 1
        flash[:notice] = t('flash.notice.question.vote.update')
      end
    end

    respond_to do |format|
      format.json { render :json => question }
    end
  end

  def tag
    @questions = Question.tagged_with(params[:id] , :on => :tags).paginate(:page => params[:page] || 1, :per_page => 20)
    @tags = Question.tag_counts_on(:tags)
    render 'index'
  end

  def unanswered
    @questions = Question.unanswered(params[:page])
    render 'index'
  end

  def hot
    @questions = Question.hot(params[:page])
    render 'index'
  end

  private
  
  def increment_total_views
    @question.increment!(:total_views)
  end

  def question_params
    params.require(:question).permit(:title, :body, :tag_list)
  end

end
