class BookcasesController < ApplicationController
  

  def show
    @bookcase = Bookcase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bookcase }
    end
  end

  
end
