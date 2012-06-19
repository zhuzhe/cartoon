class Page < ActiveRecord::Base
	belongs_to :section

	def comic
		section.comic
	end

	def path
		root = '/home/www/images/comics'
		comic_dir = "#{root}/#{self.section.comic.id}"
		section_dir = "#{comic_dir}/#{section.id}"
		Dir.mkdir(root)  unless File.exist?(root)
		Dir.mkdir(comic_dir)  unless File.exist?(comic_dir)
		Dir.mkdir(section_dir)  unless File.exist?(section_dir)
		"#{section_dir}/#{self.sequence}.jpg"
	end

	def image_path
		"/cp/#{section.comic.id}/#{section.id}/#{sequence}.jpg"
	end

	def image_path_on_disk
		"/home/www/images/comics/#{section.comic.id}/#{section.id}/#{sequence}.jpg"
	end

	def next
		next_page = Page.where("section_id = #{section.id} AND sequence = #{sequence + 1}").limit(1).first
		return unless next_page
		if  File.exist?(next_page.image_path_on_disk)
			return next_page 
		else
			return next_page.next
		end
	end

	def prev
		prev_page = Page.where("section_id = #{section.id} AND sequence = #{sequence - 1}").limit(1).first
	end
end
