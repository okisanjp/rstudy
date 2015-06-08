class UsersController < BaseController
  def index
    unless current_user
      redirect_to root_path
    end
    # @entries = Entry.find(:all, :contidions => ["user_id = ?", session[:user_id]]).order('updated_at DESC')
    @entries = Entry.where(:user_id => session[:user_id]).all.order('updated_at DESC')
  end
end
