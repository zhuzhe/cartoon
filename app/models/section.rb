require File.expand_path("../../../lib/spider/spider.rb", __FILE__)

class Section < ActiveRecord::Base
	belongs_to :comic

	has_many :pages


	def next
		Section.where(:comic_id => comic.id, :sequence => sequence + 1).limit(1).first
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
