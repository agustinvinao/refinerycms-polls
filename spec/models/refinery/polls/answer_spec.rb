require 'spec_helper'

module Refinery
  module Polls
    describe Answer do
      describe "validations" do
        subject do
          FactoryGirl.create(:answer, :title => "Answer 1")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:title) { should == "Answer 1" }
      end
    end
  end
end
