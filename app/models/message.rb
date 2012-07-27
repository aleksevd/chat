class Message < ActiveRecord::Base

  MAX_NUMBER_OF_MESSAGES = 100
  @@number_of_messages = Message.count

  attr_accessible :text, :user_id
  belongs_to :user
  validates :text, presence: true

  after_create :destroy_extent_messages
  after_destroy :decremeny_number_of_messages

  private

  def destroy_extent_messages
    @@number_of_messages += 1
    if @@number_of_messages > MAX_NUMBER_OF_MESSAGES
      Message.first.destroy
    end
  end

  def decremeny_number_of_messages
    @@number_of_messages -= 1
  end
end
