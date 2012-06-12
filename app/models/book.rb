class Book < ActiveRecord::Base

	belongs_to :bookcase

	belongs_to :comic

end
