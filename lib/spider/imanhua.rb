require 'nokogiri'
require 'open-uri'
require 'mechanize'

module Spider
	
	class Imanhua

		ROOT = "http://imanhua.com"

		def home
			@home ? @home : @home = Nokogiri::HTML(open(ROOT))
		end

		def get_page url
			agent = create_agent
			html = Iconv.iconv("UTF-8//IGNORE","GB2312//IGNORE", agent.get(url).body).to_s
			Nokogiri::HTML(html, nil, 'utf-8') 
		end

		def crawl_comics_index
			index = Nokogiri::HTML(open("#{ROOT}/all.html"))
			index.search('.allComicList li a:first').each do |a|
				next if Comic.find_by_name(a.text)
				Comic.create(:name => a.text, :url => "#{ROOT}#{a['href']}")
			end
		end

		def crawl_sections_index
			Comic.find_each do |comic|
				comic_home = get_page(comic.url)
				comic_home.search('#subBookList li a').each do |a|
					url = "#{ROOT}#{a['href']}"
					next if Section.find_by_url(url)
					sec = Section.create(:name => a.text, :url => url, :comic => comic)
					puts "#{sec.name} --- #{sec.url}" 
				end
				sleep 2
			end
			
		end

		def crawl_comic_extra_info
			Comic.find_each do |comic|
				comic_home = get_page(comic.url)
				cover = comic_home.search('.bookCover img').first
				desc = comic_home.search('.intro').first
				comic.update_attributes(:cover => "#{ROOT}#{cover['src']}",
					:description => desc.text )
				pp "#{comic.id} : #{comic.description} -- #{comic.cover}"
				sleep 2
			end
		end

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

end