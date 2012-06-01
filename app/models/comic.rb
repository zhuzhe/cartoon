class Comic < ActiveRecord::Base
	has_many :sections

	scope :enable, lambda { where("status = 1") }
	scope :disable, lambda { where("status = 0") }
	scope :hot, lambda { where("status = 1 AND hot >= 8") }
	scope :latest, lambda { where("status = 1").order("updated_at DESC") }

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
		`echo ok`
	end

	def self.get_by_sid sid
		where("url like ?", "%/#{sid}/%").limit(1).first
	end
end
