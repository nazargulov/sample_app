class UsersController < ApplicationController
  before_action :signed_in_user,          only: [:index, :edit, :update]
  before_action :correct_user,            only: [:edit, :update]
  before_action :admin_user,              only: :destroy
  before_action :signed_in_user_filter,   only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    user = User.find(params[:id])
    unless (user.admin? && current_user?(user))
      user.destroy
      flash[:success] = "User deleted."
    else
      flash[:error] = "You can't delete yourself."
    end
    redirect_to users_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email,
        :password, :password_confirmation);
    end

    # Before filters

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def signed_in_user_filter
     redirect_to root_url, notice: 'Already logged in' if signed_in?
    end
end
