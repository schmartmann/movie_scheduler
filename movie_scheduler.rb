Dir[ "./movie_scheduler/*.rb" ].each { | file | require file }
require 'pry'

begin
  file_name = ARGV[ 0 ]
  
  movies = MovieScheduler::Movies.list_movies( file_name )

  movies.each do | movie |

    MovieScheduler::Theater.build_movie_schedule( movie )

  end

rescue => error
  puts error
end
