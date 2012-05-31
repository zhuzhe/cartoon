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

	desc "crawl pages"
	task :crawl_pages => :environment do
		Spider::Imanhua.new.crawl_pages(Comic.get_by_sid(1809), 'imanhua_', 'jpg')
		puts 'done'
	end

	desc "analysis pages info"
	task :analysis_pages_info => :environment do
		Spider::Imanhua.new.analysis_pages_info
		puts 'done'
	end

	desc "analysis pages info"
	task :analysis_pages_info2 => :environment do
		Spider::Imanhua.new.analysis_pages_info2
		puts 'done'
	end

	desc "download pages"
	task :download_pages => :environment do
		Spider::Imanhua.new.download_pages
		puts 'done'
	end

	desc "crawl comics by category"
	task :crawl_comics_by_category => :environment do
		Spider::Imanhua.new.crawl_comics_by_category
		puts 'done'
	end

	desc "refresh sections sequence"
	task :refresh_sections_sequence => :environment do
		Spider::Imanhua.new.refresh_sections_sequence
		puts 'done'
	end

end