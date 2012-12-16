# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rubygems'           #so it can load gems
require 'factory_girl_rails' #so it can run in development

Post.delete_all
if (ENV['RAILS_ENV'] == 'production')
  ActiveRecord::Base.connection.execute("TRUNCATE taggings")
  ActiveRecord::Base.connection.execute("TRUNCATE tags")
else
  ActiveRecord::Base.connection.execute("DELETE FROM taggings")
  ActiveRecord::Base.connection.execute("DELETE FROM tags")
end

100.times do
  FactoryGirl.create(:post)
end


