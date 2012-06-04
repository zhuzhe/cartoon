class ComicsController < ApplicationController

  before_filter :find_comic

  def show
  end
 

  def search
    @comics = Comic.where("name like ?", "%#{params[:key]}%")
  end

  def hot
    @comics = Comic.hot
  end

  def latest
    @today_sections = Section.today
  end

  private

  def find_comic
    @comic = Comic.find(params[:id]) if params[:id]
  end

end
