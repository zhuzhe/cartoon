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
		"#{section_dir}/#{self.order}.jpg"
	end

	def image_path
		"/cp/#{section.comic.id}/#{section.id}/#{order}.jpg"
	end

	def next
		next_page = Page.where("section_id = #{section.id} AND sequence = #{sequence + 1}").limit(1).first
	end

	def prev
		prev_page = Page.where("section_id = #{section.id} AND sequence = #{sequence - 1}").limit(1).first
	end
end
