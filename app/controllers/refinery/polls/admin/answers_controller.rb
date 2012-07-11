module Refinery
  module Polls
    module Admin
      class AnswersController < ::Refinery::AdminController

        crudify :'refinery/polls/answer', :title_attribute => 'title', :xhr_paging => true
        before_filter :find_question 
        before_filter :find_answer, :only => [:edit, :update]
        
        def index
          paginate_all_answers
        end
        def edit
          
        end

        def create
          if (@answer = ::Refinery::Polls::Answer.create({:question_id => @question.id}.merge(params[:answer]))).valid?
            flash.now[:notice] = "#{@answer.title} was successfully created."
            self.index
            @dialog_successful = true
            render :index
          else
            render :action => 'new'
          end
        end

        def update
          if @answer.update_attributes({:question_id => @question.id}.merge(params[:answer]))
            flash.now[:notice] = "#{@answer.title} was successfully updated."
            self.index
            @dialog_successful = true
            render :index
          else
            render :action => 'edit'
          end
        end
        
        private
        def find_answer
          @answer = ::Refinery::Polls::Answer.find_by_slug_or_id(params[:id])
        end
        
        def find_question
          @question = ::Refinery::Polls::Question.find_by_slug_or_id(params[:question_id])
        end

        def paginate_all_answers
           @answers = ::Refinery::Polls::Answer.paginate :page => params[:page], 
                                                         :conditions => {:question_id => @question.id} if Refinery::Polls::Admin::QuestionsController.pageable? 
        end
      end
    end
  end
end