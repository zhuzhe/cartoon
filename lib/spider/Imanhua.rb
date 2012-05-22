require 'nokogiri'
require 'open-uri'

module Spider
	
	class Imanhua

		ROOT = "http://imanhua.com/"

		def home
			@home ? @home : @home = Nokogiri::html(open(ROOT))
		end

		def crawl_comics
			
		end
		
	end

end