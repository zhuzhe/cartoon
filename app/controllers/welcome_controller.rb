class WelcomeController < ApplicationController
  def index
  	@comics = Comic.limit(8)
  end

  def latest
  end

  def hot
  end
end
