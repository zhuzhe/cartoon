class ComicsController < ApplicationController

  before_filter :find_comic

  def show
  end
 

  def search
    @comics1 = Comic.search_by_name_like(params[:key])
    @comic2 = Comic.search_by_tag_name(params[:key])
    @comics = @comics1 | @comic2
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
