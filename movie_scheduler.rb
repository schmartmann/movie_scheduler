Dir[ "./movie_scheduler/*.rb" ].each { | file | require file }
require 'pry'

begin
  file_name = ARGV[ 0 ]
  MovieScheduler::Movies.list_movies( file_name )
rescue => error
  puts error
end
