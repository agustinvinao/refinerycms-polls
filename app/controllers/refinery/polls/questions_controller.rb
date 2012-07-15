module Refinery
  module Polls
    class QuestionsController < ::ApplicationController

      before_filter :find_all_questions, :only => [:index, :show]
      before_filter :find_page, :except => [:submit]
      before_filter :find_question, :only => [:submit, :show]
      before_filter :find_answer, :only => [:submit]
      before_filter :find_vote, :only => [:show, :create, :submit]
      respond_to :html, :js, :json
      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @poll in the line below:
        present(@page)
      end

      def show
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @poll in the line below:
        present(@page)
      end
      
      def submit
        if @vote.nil?
          if @answer.nil?
            flash[:notice] = t(".no_answer_selected")
          else
            Rails.logger.info(">>>VOTE COUNT (BEFORE CREATE): #{::Refinery::Polls::Vote.count}")
            @vote = ::Refinery::Polls::Vote.vote_by_ip(@answer, request.remote_ip)
          end
        end
        respond_to do |format|
          format.js
          format.html
        end
      end

    protected
      def find_question
        @question = ::Refinery::Polls::Question.find_by_slug_or_id(params[:id])
      end
      
      def find_answer
        @answer = ::Refinery::Polls::Answer.find_by_slug_or_id(params[:answer_id])
      end
      
      def find_all_questions
        @questions = ::Refinery::Polls::Question.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/polls").first
      end
      
      def find_vote
        @vote = ::Refinery::Polls::Vote.get_vote(@question, request.remote_ip)
      end
    end
  end
end