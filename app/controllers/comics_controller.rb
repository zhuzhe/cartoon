class ComicsController < ApplicationController

  before_filter :find_comic

  def show
  end
 

  def search
    @comics1 = Comic.search_by_name_like(params[:key])
    @comic2 = Comic.search_by_tag_name(params[:key])
    @comics = (@comics1 | @comic2).paginate(:page => params[:page], :per_page => 20)
  end

  def hot
    @comics = Comic.hot.paginate(:per_page => 20, :page => params[:page])
  end

  def latest
    @comics = Comic.latest.limit(100).paginate(:per_page => 20, :page => params[:page])
  end



  private

  def find_comic
    @comic = Comic.find(params[:id]) if params[:id]
  end

end
