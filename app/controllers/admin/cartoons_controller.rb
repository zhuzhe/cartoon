class Admin::CartoonsController < Admin::ApplicationController
  def index

  	@cartoons = Cartoon.paginate(:per_page => 50, :page => params[:page])

  end

  def show
  end
end
