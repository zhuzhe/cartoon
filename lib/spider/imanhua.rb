require 'nokogiri'
require 'open-uri'
require 'mechanize'
require 'mini_magick'

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
			Comic.enable.find_each do |comic|
				next unless comic.sections.blank?
				comic_home = get_page(comic.url)
				comic_home.search('#subBookList li a').reverse.each_with_index do |a, index|
					url = "#{ROOT}#{a['href']}"
					next if Section.find_by_url(url)
					sec = Section.create(:name => a.text, :url => url, :comic => comic, :sequence => index + 1)
					puts "#{sec.name} --- #{sec.url}" 
				end
				sleep 2
			end
			
		end

		def crawl_pages comic, prefix, suffix
			comic.sections.each do |section|
				page = get_page(section.url)
				page.search('#drop option').each do |option|
				  puts	"http://t6.mangafiles.com/Files/Images/#{section.comic.url.match(/\d+/).to_s}/#{section.url.match(/_(\d+)/).to_s.gsub('_', '')}/#{prefix}#{option['value'].to_s.rjust(3, '0')}.#{suffix}"
				end
				return
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

		def analysis_pages_info

			Comic.enable.find_each do |comic|
				comic.sections.find_each do |section|
					puts section.url
					begin
						s_page = get_page(section.url)
					
					s_page.content.match(/setting.chapterInfo=(\{.*\})/)
					next if $1.nil?
					info = JSON.parse($1)
					info['images'].each_with_index do |suffix, index|
						puts image = "http://t6.mangafiles.com/Files/Images/#{info['bookId']}/#{info['chapterId']}/#{suffix}"
						next if Page.find_by_url(image)
						Page.create(:section => section, :url => image, :order => (index + 1))
						
					end
	
					rescue Exception => e
						next
					end
					sleep 3
				end
			end
		end

		def analysis_pages_info2
			Comic.enable.find_each do |comic|
				comic.sections.find_each do |section|
					puts section.url
					begin
						s_page = get_page(section.url)
					
					s_page.content.match(/,'(\w{3}\|.*)'\.split/)
					next if $1.nil?
					info = $1.split('|')
					suffix = info.shift
					images = []
					info.each do |item|
						images << item if item.match('_')
					end
					images.sort!.each_with_index do |image, index|
					   puts url ="http://t6.mangafiles.com/Files/Images/#{section.comic.url.match(/\d+/).to_s}/#{section.url.match(/_(\d+)/).to_s.gsub('_', '')}/#{image}.#{suffix}"
					   next if Page.find_by_url(url)
					   Page.create(:section => section, :order => index, :url => url)
					end
	
					rescue Exception => e
						next
					end
					sleep 3
				end
			end
		end

		def download_pages
			Comic.enable.each do |comic|
				next if [3,4,11,14].include?(comic.id)
				comic.sections.each do |section|
					section.pages.each do |page|
						next if File.exist? page.path
						puts page.url
						begin
						open(page.url, {"Referer" => page.section.url}) do |f|
							File.open(page.path, 'w') do |new_file|
								new_file.write(f.read)
							end
							MiniMagick::Image.open(page.path).write page.path
						end
						rescue Exception => e
							next
						end
						sleep 3
					end
				end
			end
		end

		def crawl_comics_by_category

			["http://imanhua.com/comic/shaonian/", 
			  "http://imanhua.com/comic/wuxia/", 
			  "http://imanhua.com/comic/kehuan/", 
			  "http://imanhua.com/comic/tiyu/",
			   "http://imanhua.com/comic/xiju/", 
			   "http://imanhua.com/comic/kongbu/",
			    "http://imanhua.com/comic/tuili/", 
			    "http://imanhua.com/comic/japan/"].each do |category_url|
				doc = get_page(category_url)
				analysis_category_page doc

				(2..50).each do |i|
				  	begin
				  	 doc = get_page("#{category_url}index_p#{i}.html")
				   	 analysis_category_page doc	
					rescue Exception => e
					    next
					end
				end
			end
		end

		def refresh_sections_sequence
			Comic.find_each do |comic|
				comic.sections.reverse.each_with_index do |section, index|
					next if section.sequence != 0
					section.sequence = index + 1
					section.save
					puts "#{section.id}  :  #{section.sequence}"
				end
			end
		end

		private

		def analysis_category_page doc
			doc.search('.bookList li > a').each do |a|
				  url = "#{ROOT}#{a['href']}"
				  puts url
				  next if Comic.find_by_url(url)
				  c = Comic.create(:name => a.text, :url => url, :cover => a.search('img').first['src'])
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