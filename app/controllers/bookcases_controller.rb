class BookcasesController < ApplicationController
  # GET /bookcases
  # GET /bookcases.json
  def index
    @bookcases = Bookcase.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @bookcases }
    end
  end

  # GET /bookcases/1
  # GET /bookcases/1.json
  def show
    @bookcase = Bookcase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @bookcase }
    end
  end

  # GET /bookcases/new
  # GET /bookcases/new.json
  def new
    @bookcase = Bookcase.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @bookcase }
    end
  end

  # GET /bookcases/1/edit
  def edit
    @bookcase = Bookcase.find(params[:id])
  end

  # POST /bookcases
  # POST /bookcases.json
  def create
    @bookcase = Bookcase.new(params[:bookcase])

    respond_to do |format|
      if @bookcase.save
        format.html { redirect_to @bookcase, :notice => 'Bookcase was successfully created.' }
        format.json { render :json => @bookcase, :status => :created, :location => @bookcase }
      else
        format.html { render :action => "new" }
        format.json { render :json => @bookcase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bookcases/1
  # PUT /bookcases/1.json
  def update
    @bookcase = Bookcase.find(params[:id])

    respond_to do |format|
      if @bookcase.update_attributes(params[:bookcase])
        format.html { redirect_to @bookcase, :notice => 'Bookcase was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @bookcase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bookcases/1
  # DELETE /bookcases/1.json
  def destroy
    @bookcase = Bookcase.find(params[:id])
    @bookcase.destroy

    respond_to do |format|
      format.html { redirect_to bookcases_url }
      format.json { head :no_content }
    end
  end
end
