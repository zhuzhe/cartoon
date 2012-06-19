class SectionsController < ApplicationController
  

  def show
    @section = Section.find(params[:id])
    params[:page_id].blank? ? @page = @section.first_page : @page = Page.find(params[:page_id]) 
    case params[:tag]
      when 'next' : @page = @page.next
      when 'prev' : @page = @page.prev
    end

    if params[:tag] == 'next' && @page.nil?
      if @section.next
         redirect_to section_path(@section.next)
        else
         redirect_to comic_path(@section.comic) 
      end
      
    end

  end

end
