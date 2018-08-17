Dir[ "./movie_scheduler/*.rb" ].each { | file | require file }
require 'pry'


t = MovieScheduler::Theater.new
puts t.operating_hours
# file_name = ARGV[ 0 ]
#
# begin
#   puts File.read( file_name )
# rescue
#   binding.pry
# end
