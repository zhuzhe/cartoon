class QuencesController < ApplicationController
  # GET /quences
  # GET /quences.json
  def index
    @quences = Quence.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @quences }
    end
  end

  # GET /quences/1
  # GET /quences/1.json
  def show
    @quence = Quence.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @quence }
    end
  end

  # GET /quences/new
  # GET /quences/new.json
  def new
    @quence = Quence.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @quence }
    end
  end

  # GET /quences/1/edit
  def edit
    @quence = Quence.find(params[:id])
  end

  # POST /quences
  # POST /quences.json
  def create
    @quence = Quence.new(params[:quence])

    respond_to do |format|
      if @quence.save
        format.html { redirect_to @quence, :notice => 'Quence was successfully created.' }
        format.json { render :json => @quence, :status => :created, :location => @quence }
      else
        format.html { render :action => "new" }
        format.json { render :json => @quence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /quences/1
  # PUT /quences/1.json
  def update
    @quence = Quence.find(params[:id])

    respond_to do |format|
      if @quence.update_attributes(params[:quence])
        format.html { redirect_to @quence, :notice => 'Quence was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @quence.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /quences/1
  # DELETE /quences/1.json
  def destroy
    @quence = Quence.find(params[:id])
    @quence.destroy

    respond_to do |format|
      format.html { redirect_to quences_url }
      format.json { head :no_content }
    end
  end
end
