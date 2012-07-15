require 'spec_helper'

module Refinery
  module Polls
    describe Question do
      describe "validations" do
        subject do
          FactoryGirl.create(:question,
          :title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Refinery CMS" }
      end
      describe "class methods" do
        before do 
          Factory.create(:question) 
          Factory.create(:question, 
                          start_date: Time.now+2.days, 
                          end_date: Time.now+10.days) 
        end
        subject { Question.first }
        it "should get one question active" do 
          Question.actives.should == [subject]
        end
      end
      describe "instance methods" do
        before do
          question = Factory.create(:question)
          @times = 3
          @answer = Factory.create(:answer, question: question)
          (@times-1).times{ Factory.create(:answer, question: question) }
          @ip = "192.168.1.1"
          @vote = Factory.create(:vote, answer: @answer, ip: @ip)
        end
        subject{ Question.first }
        it { subject.answers.size == @times }
        it { subject.total_votes.should == subject.answers.sum(&:votes_count) }
        it "should get answers data for view" do
          subject.answers_with_data.should == [subject.answers.collect{|a| [a.title, a.votes_count]}, subject.total_votes]
        end
        it { subject.already_voted?("127.0.0.1").should be_false }
        it { subject.already_voted?("192.168.1.1").should be_nil }
      end
    end
  end
end
