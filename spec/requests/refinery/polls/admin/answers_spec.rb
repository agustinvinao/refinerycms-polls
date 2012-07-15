# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Polls" do
    describe "Admin" do
      describe "Answers" do
        login_refinery_user

        describe "answers list" do
          before(:each) do
            @question = FactoryGirl.create(:question)
            Factory.create(:answer, question: @question, title: "Option_1")
            Factory.create(:answer, question: @question, title: "Option_2")
          end

          it "shows two items" do
            visit refinery.polls_admin_question_answers_path(@question)
            page.should have_content("Option_1")
            page.should have_content("Option_2")
          end
        end

        describe "create" do
          before(:each) do
            @question = FactoryGirl.create(:question)
            visit refinery.polls_admin_question_answers_path(@question)
        
            click_link "Add New Question Answer"
          end
        
          context "valid data" do
            it "should succeed" do
              fill_in "Title", :with => "This is a test of the first string field"
              click_button "Save"
        
              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Polls::Answer.count.should == 1
            end
          end
        
          # we can't test this because admin/answers/_form.html creates wrong url helper for nested models
          # context "invalid data" do
          #   it "should fail" do
          #     click_button "Save"
          #         
          #     page.should have_content("Title can't be blank")
          #     Refinery::Polls::Answer.count.should == 0
          #   end
          # end
        
          # we can't test this because admin/answers/_form.html creates wrong url helper for nested models
          # context "duplicate" do
          #   before(:each) do
          #     @question = FactoryGirl.create(:question, :title => "UniqueTitle") 
          #     Factory.create(:answer, question: @question, :title => "Option repeated")
          #   end
          #         
          #   it "should fail" do
          #     visit refinery.polls_admin_question_answers_path(@question)
          #         
          #     click_link "Add New Question Answer"
          #         
          #     fill_in "Title", :with => "Option repeated"
          #     click_button "Save"
          #         
          #     page.should have_content("There were problems")
          #     Refinery::Polls::Answer.count.should == 1
          #   end
          # end
        
        end
        
        describe "edit" do
          before(:each) do 
            @question = FactoryGirl.create(:question, :title => "A title")
            Factory.create(:answer, question: @question)
          end
        
          it "should succeed" do
            visit refinery.polls_admin_question_answers_path(@question)
        
            within ".actions" do
              click_link "Edit this question answer"
            end
        
            fill_in "Title", :with => "A different title"
            click_button "Save"
        
            page.should have_content("'A different title' was successfully updated.")
            page.should have_no_content("A title")
          end
        end
        
        describe "destroy" do
          before(:each) do 
            @question = FactoryGirl.create(:question, :title => "A title")
            Factory.create(:answer, question: @question, title: "UniqueTitleOne")
          end
        
          it "should succeed" do
            visit refinery.polls_admin_question_answers_path(@question)
        
            click_link "Remove this question answer forever"
        
            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Polls::Answer.count.should == 0
          end
        end

      end
    end
  end
end
