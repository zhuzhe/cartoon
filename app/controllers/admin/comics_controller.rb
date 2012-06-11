class Admin::ComicsController < Admin::ApplicationController

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
  	@comics = Comic.disable.paginate(:per_page => 50, :page => params[:page]).order('status DESC')
  end

  def update
  	@comic.update_attributes(params[:post])
  	redirect_to :back
  end

  def update_hot
  	@comic.update_attribute(:hot, params[:comic])
  	render :json => {:status => 'succes'}
  end

  def update_section_list
    @comic.update_section_list
    redirect_to :back
  end

  def update_all_sections
    Comic.update_all_sections
    redirect_to :back
  end

  def add_tag
    params[:tags].split(' ').each do |t|
      tag = Tag.find_by_name(t)
      unless tag
        tag = Tag.create(:name => t)
      end
      unless @comic.tags.include?(tag)
        @comic.tags << tag
      end
    end
    redirect_to :back
  end

  def recommand
    @comic.push_in_recommand_quence
    redirect_to :back
  end

  private

  def find_model
  	@comic = Comic.find(params[:id]) if params[:id]
  end
end
