class User < ActiveRecord::Base

	validates :email, :presence => {:message => "邮箱不能为空"}, 
					  :uniqueness => {:message => '此邮箱已经存在'},
					  :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => "邮箱格式错误"}
	validates :name,
					 :length => { :in => 4..15, :message => "昵称长度为4到15位" }	
	validates :password,
						 :length => { :in => 6..15, :message => "密码长度为6到15位" }	

	has_one :bookcase, :dependent => :destroy
	has_many :books, :through => :bookcase
	has_many :comics, :through => :books




	after_create do |user|
		Bookcase.create(:user_id => user.id)
	end

	def add_comic_to_bookcase comic
		return if Book.find_by_comic_id_and_bookcase_id(comic.id, bookcase.id)
		Book.create(:comic_id => comic.id, :bookcase_id => bookcase.id)
	end

	def comics_order_by_update_section_time
		comics.sort do |a, b|
			b.sections.first.created_at <=> a.sections.first.created_at
 		end
	end

	class << self

		def authenticate email, password
		   find_by_email_and_password(email, password)
		end

	end

	

end
