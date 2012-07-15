require 'spec_helper'

module Refinery
  module Polls
    describe Vote do
      describe "validations" do
        subject do
          FactoryGirl.create(:vote)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
      describe "class methods" do
        before do 
          question = Factory.create(:question)
          @answer = Factory.create(:answer, question: question)
          @vote = Factory.create(:vote, answer: @answer)
          @ip = "192.168.1.1"
        end
        it "should create a vote by ip for an Answer" do 
          vote = Vote.vote_by_ip(@answer, @ip)
          vote.should be_valid
          vote.ip.should == @ip
        end
        it "should get a vote by ip for a Question" do
          Vote.get_vote(@question, @ip) == @vote
        end
      end
      describe "instance methods" do
        #nothing
      end
    end
  end
end
