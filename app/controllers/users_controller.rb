class UsersController < ApplicationController
  
  before_filter :find_user
  before_filter :require_login, :only => [:favorite_book]

  def show
    @user = User.find(params[:id])
    @comics = @user.comics_order_by_update_section_time
  end

  def new
    @user = User.new
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
