class AnswersController < ApplicationController
  before_filter :load_question, :except => [:comment, :vote , :select , :flag ,:edit , :update]
  skip_before_filter :verify_authenticity_token

  def new
    @answer = @question.answers.build
    render :layout => false
  end

  def create
    @answer = @question.answers.build(:user => current_user , :body => params[:body])
    if @answer.save
      flash[:notice] = t('flash.notice.answer.create.valid')
    else
      flash[:notice] = t('flash.notice.answer.create.invalid')
    end
    respond_to do |format|
      format.html { render :layout => false } # redirect_to question_path(@question)}
      format.js { Rails.logger.info "in JS handler" }
      format.json { render :json => answer }
    end
  end

  def edit
    @answer = current_user.answers.find(params[:id])
  end

  def update
    @answer = current_user.answers.find(params[:id])
    respond_to do |format|
      if @answer.update_attributes(:body => params[:answer][:body])
        flash[:notice] = t('flash.notice.answer.update.valid')
        format.html{redirect_to question_path(@answer.question)}
      else
        flash[:notice] = t('flash.notice.answer.update.invalid')
        format.html{render 'edit'}
      end
    end

  end

  def comment
    answer = Answer.find(params[:id])
    comment = answer.comments.create
    comment.title = "answer - " + params[:id]
    comment.comment = params[:body]
    comment.user_id = current_user
    if comment.save
      flash[:notice] = t('flash.notice.question.create.valid')
    else
      flash[:notice] = t('flash.notice.question.create.invalid')
    end
    respond_to do |format|
      format.html { redirect_to question_path(answer.question)}
      format.json { render :json => comment }
    end
  end

  def vote
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.find_by_user_id(current_user.id)
    if @vote
      if @vote.vote.to_s == params[:vote]
        flash[:notice] = t('flash.notice.answer.vote.nochange')
      else
        @vote.update_attributes(:vote => params[:vote])
        flash[:notice] = t('flash.notice.answer.vote.update')
      end
    else
      @vote = @answer.votes.build(:user => current_user , :vote => params[:vote])
      if @vote.save
        flash[:notice] = t('flash.notice.answer.vote.valid')
      else
        flash[:notice] = t('flash.notice.answer.vote.invalid')
      end
    end
    respond_to do |format|
      format.js {}
    end  
  end
  
  
  def select
    @answer = Answer.find(params[:id])
    if @answer.question.user == current_user
      @prev_selected = @answer.select!
      flash[:notice] = t('flash.notice.answer.select.valid')
    else
      flash[:notice] = t('flash.notice.answer.select.invalid')
    end  
    respond_to do |format|
      format.js {}
    end
  end
  
  private
  
  def load_question
    @question = Question.find(params[:question_id])
  end  
  
end
