require File.expand_path('../imanhua.rb', __FILE__)

module Spider

	def create_agent
		agent = Mechanize.new
		agent.user_agent_alias = "Windows IE 7"
		agent.request_headers = {
			'Accept-Charset'=> 'ISO-8859-1,utf-8;q=0.7,*;q=0.3',
			'Accept-Language'=> 'en-US,en;q=0.8',
			'Cache-Control'=> 'max-age=0',
			'Accept-Encoding'=> 'gzip,deflate,sdch'
		}
		agent
	end


end