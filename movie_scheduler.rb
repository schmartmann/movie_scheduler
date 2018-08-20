require 'date'
require 'pry'


Dir[ "./movie_scheduler/*.rb" ].each { | file | require file }

begin
  file_name = ARGV[ 0 ]

  movies = MovieScheduler::Movies.list_movies( file_name )

  showings = []

  movies.each do | movie |
    showings.push( MovieScheduler::Theater.build_movie_schedule( movie ) )
  end

  readout = MovieScheduler::Readout.new.print_schedule( showings )
  print readout

rescue => error
  puts error
end
