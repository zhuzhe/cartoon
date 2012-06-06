require File.expand_path("../../../lib/spider/spider.rb", __FILE__)

class Comic < ActiveRecord::Base
	has_many :sections, :order => 'sequence DESC'
	has_and_belongs_to_many :tags

	scope :enable, lambda { where("status = 1") }
	scope :disable, lambda { where("status = 0") }
	scope :hot, lambda { where("status = 1 AND hot >= 8") }
	scope :latest, lambda { where("status = 1").order("updated_at DESC") }
	scope :enable_end, lambda { where("status = 1 AND nature = 1")}
	scope :enable_continue, lambda { where("status = 1 AND nature = 0")}
	scope :search_by_name_like, lambda {|name| where("status = 1 AND name like ?", "%#{name}%")}
	scope :search_by_tag_name, lambda {|name| joins(:tags).where("status = 1 AND tags.name like ?", "%#{name}%") }

	def enable?
		status == 1 ? true : false
	end

	def enable
		update_attribute(:status, 1)
	end

	def disable
		update_attribute(:status, 0)
	end

	def update_section_list
		Thread.new {
			Spider::Imanhua.new.update_comic(self)
		}
	end

	def cover_path
		"/covers_picture/#{id}.jpg"
	end

	def nature_explain
		case nature
		when 1 : '已完结'
		when 0 : '未完结'
		end
	end

	def latest_section
		Section.where(:comic_id => self.id).order('sequence DESC').limit(1).first
	end

	

	class << self

		def get_by_sid sid
			where("url like ?", "%/#{sid}/%").limit(1).first
		end

		def update_all_sections
			enable_continue.each do |comic|
				Thread.new {
					Spider::Imanhua.new.update_comic comic
				}	
			end
		end

		def today
		    where("created_at > #{(Time.now - 1.day)}").order('created_at DESC')
		end

	end
end
