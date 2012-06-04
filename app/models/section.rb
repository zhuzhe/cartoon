class Section < ActiveRecord::Base
	belongs_to :comic

	has_many :pages


	def next
		Section.where(:comic => comic, :sequence => sequence + 1)
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
