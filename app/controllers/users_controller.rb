class UsersController < ApplicationController
  
  before_filter :find_user

  def show
    @user = User.find(params[:id])
    @comics = @user.comics
  end

  def new
    @user = User.new
  end


  def edit
    @user = User.find(params[:id])
  end


  def create
    @user = User.new(params[:user])
      if @user.save
        login @user
        redirect_to root_path
      else
        render :action => "new"
      end
  end

  def favorite_book
    @comic = Comic.find(params[:comic_id])
    current_user.add_comic_to_bookcase @comic
    redirect_to :back
  end

  private

  def find_user
    @user = User.find(params[:id]) if params[:id]
  end


end
