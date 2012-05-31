class WelcomeController < ApplicationController
  def index
  	@hot = Comic.hot.limit(8)
  	@latest = Comic.latest.limit(8)
  end

  def latest
  end

  def hot
  end
end
