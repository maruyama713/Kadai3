class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:hoge] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

   private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(user_path(current_user.id)) unless @user == current_user
  end

end
