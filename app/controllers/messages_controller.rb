class MessagesController < InheritedResources::Base

  skip_before_filter :authenticate_user!, only: :index

  before_filter :set_user_to_params, only: [:create, :update]
  before_filter :set_messages, only: :index

  def index
  end

  def create
    create! { root_url }
  end

  def destroy
    destroy! { root_url }
  end

  def update
    update! { root_url }
  end

  private

  def set_user_to_params
    params[:message][:user_id] = current_user.id
  end

  def set_messages
    @messages = Message.order("created_at ASC").includes(:user)
    @message = Message.new
  end
end
