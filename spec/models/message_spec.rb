require 'spec_helper'
MAX_MESSAGE = Message::MAX_NUMBER_OF_MESSAGES

describe Message do
  context ".create" do
    it { should validate_presence_of(:text) }
    it { should belong_to(:user) }

    (MAX_MESSAGE).times do
      FactoryGirl.create :message, user_id: 1
    end

    it "should save #{MAX_MESSAGE} messages" do
      Message.count.should == MAX_MESSAGE
    end

    context "after reaching message limit" do
      before(:each) do
        @m = FactoryGirl.create :message, user_id: 1
      end

      it "should not increase number of messages" do
        Message.count.should == MAX_MESSAGE
      end

      it "should not destroy last message" do
        @m.should == Message.last
      end

      it "should destroy old message" do
        first_message = Message.first
        FactoryGirl.create :message, user_id: 1
        expect { first_message.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end