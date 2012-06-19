require File.expand_path("../../../lib/spider/spider.rb", __FILE__)

class Section < ActiveRecord::Base
	belongs_to :comic

	has_many :pages

	after_create do |section|
		section.comic.update_attribute(:updated_at, Time.now)
	end

	def first_page
		page = pages.first
		if File.exist? page.image_path_on_disk
			return page
		else
			return page.next
		end
	end


	def next
		next_section = Section.where(:comic_id => comic.id, :sequence => sequence + 1).limit(1).first
		if next_section && next_section.pages.blank?
			return nil
		end
		next_section
	end

	def update_pages
		Spider::Imanhua.new.update_section self
	end



	class << self

		def today
			 where("created_at >= '#{(Time.now.strftime("%Y-%m-%d"))}'").order('created_at DESC')
		end

		def yesterday
			where("created_at >= '#{((Time.now - 1.day).strftime("%Y-%m-%d"))}'").order('created_at DESC')
		end
	end

end
