class Admin::ComicsController < ApplicationController

	before_filter :find_model

  def index
  	@comics = Comic.paginate(:per_page => 50, :page => params[:page]).order('status DESC')
  end

  def show
  end

  def enable
  	@comic.enable
  	redirect_to :back
  end

  def disable
  	@comic.disable
  	redirect_to :back
  end

  def enable_list
  	@comics = Comic.enable.paginate(:per_page => 10, :page => params[:page]).order('status DESC')
  end

  def disable_list
  	@comics = Comic.paginate(:per_page => 10, :page => params[:page]).order('status DESC')
  end

  def update
  	@comic.update_attributes(params[:post])
  	redirect_to :back
  end

  def update_hot
  	@comic.update_attribute(:hot, params[:comic])
  	render :json => {:status => 'succes'}
  end

  private

  def find_model
  	@comic = Comic.find(params[:id]) if params[:id]
  end
end
