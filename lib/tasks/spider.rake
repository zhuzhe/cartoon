require File.expand_path('../../spider/spider.rb', __FILE__)

namespace :spider do

	desc 'crawl comic index'
	task :crawl_comics_index => :environment do
		Spider::Imanhua.new.crawl_comics_index
		puts 'done'
	end

	desc "crawl setions of comics"
	task :crawl_sections_index => :environment do
		Spider::Imanhua.new.crawl_sections_index
		puts 'done'
	end

	desc "crawl comics info"
	task :crawl_comic_extra_info => :environment do
		Spider::Imanhua.new.crawl_comic_extra_info
		puts 'done'
	end

end