# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
['热血','格斗','魔幻','科幻','喜剧','推理','恐怖','灵异'].each do |i|
	next if Tag.find_by_name(i)
	Tag.create(:name => i)
end
