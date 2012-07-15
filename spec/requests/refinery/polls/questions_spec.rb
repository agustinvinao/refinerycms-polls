# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Polls" do
    describe "Questions" do
      login_refinery_user
    
      describe "questions index" do
        before(:each) do
          FactoryGirl.create(:question, :title => "UniqueTitleTwo")
          FactoryGirl.create(:question, :title => "UniqueTitleOne")
        end
          
        it "shows two items" do
          visit refinery.polls_questions_path
          page.should have_content("UniqueTitleOne")
          page.should have_content("UniqueTitleTwo")
        end
      end
      describe "question show" do
        before(:each) do
          @question = FactoryGirl.create(:question, :title => "UniqueTitleOne")
        end
        it "shows question" do
          visit refinery.polls_question_path(@question)
          page.should have_content(@question.title)
          page.should have_content(I18n.l(@question.start_date, :format => :short))
          page.should have_content(I18n.l(@question.end_date, :format => :short))
          page.should have_content(@question.total_votes)
        end
      end

      describe "question answer submit" do
        before(:each) do
          @question = FactoryGirl.create(:question, title: "submite_test")
          @answers = []
          3.times do |value|
            @answers << Factory.create(:answer, question: @question, title: "Option #{value}")
          end
          ActionDispatch::Request.any_instance.stub(:remote_ip).and_return("192.168.0.1")
          
        end
        it "should save vote", :js => true do
          post refinery.submit_polls_question_path(@question), :answer_id => @answers.first.id, :format=> 'js'
          Refinery::Polls::Vote.count.should == 1
          @answers.first.votes_count == 1
          @question.total_votes.should == 1
        end
        it "should not save second vote from same ip", :js => true do
          Factory.create(:vote, question: @question, answer: @answers.first, ip: "192.168.0.1")
          #second call to submit
          post refinery.submit_polls_question_path(@question), :answer_id => @answers.first.id, :format=> 'js'
          Refinery::Polls::Vote.count.should == 1
          @answers.first.votes_count == 1
          @question.total_votes.should == 1
        end
        
      end
    # 
    #   describe "create" do
    #     before(:each) do
    #       visit refinery.polls_admin_questions_path
    # 
    #       click_link "Add New Question"
    #     end
    # 
    #     context "valid data" do
    #       it "should succeed" do
    #         fill_in "Title", :with => "This is a test of the first string field"
    #         click_button "Save"
    # 
    #         page.should have_content("'This is a test of the first string field' was successfully added.")
    #         Refinery::Polls::Question.count.should == 1
    #       end
    #     end
    # 
    #     context "invalid data" do
    #       it "should fail" do
    #         click_button "Save"
    # 
    #         page.should have_content("Title can't be blank")
    #         Refinery::Polls::Question.count.should == 0
    #       end
    #     end
    # 
    #     context "duplicate" do
    #       before(:each) { FactoryGirl.create(:question, :title => "UniqueTitle") }
    # 
    #       it "should fail" do
    #         visit refinery.polls_admin_questions_path
    # 
    #         click_link "Add New Question"
    # 
    #         fill_in "Title", :with => "UniqueTitle"
    #         click_button "Save"
    # 
    #         page.should have_content("There were problems")
    #         Refinery::Polls::Question.count.should == 1
    #       end
    #     end
    # 
    #   end
    # 
    #   describe "edit" do
    #     before(:each) { FactoryGirl.create(:question, :title => "A title") }
    # 
    #     it "should succeed" do
    #       visit refinery.polls_admin_questions_path
    # 
    #       within ".actions" do
    #         click_link "Edit this question"
    #       end
    # 
    #       fill_in "Title", :with => "A different title"
    #       click_button "Save"
    # 
    #       page.should have_content("'A different title' was successfully updated.")
    #       page.should have_no_content("A title")
    #     end
    #   end
    # 
    #   describe "destroy" do
    #     before(:each) { FactoryGirl.create(:question, :title => "UniqueTitleOne") }
    # 
    #     it "should succeed" do
    #       visit refinery.polls_admin_questions_path
    # 
    #       click_link "Remove this question forever"
    # 
    #       page.should have_content("'UniqueTitleOne' was successfully removed.")
    #       Refinery::Polls::Question.count.should == 0
    #     end
    #   end
    
    end
  end
end
