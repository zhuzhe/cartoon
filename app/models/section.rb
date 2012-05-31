class Section < ActiveRecord::Base
	belongs_to :comic

	has_many :pages


	def next
		Section.where(:comic => comic, :sequence => sequence + 1)
	end
end
