require 'date'
require 'pry'


Dir[ "./movie_scheduler/*.rb" ].each { | file | require file }

module MovieScheduler
  def self.schedule( file, weekday )
    begin
      showings = []

      movies = ingest_file( file )

      movies.each do | movie |
        showings.push( MovieScheduler::Theater.build_movie_schedule( movie, weekday ) )
      end

      readout = MovieScheduler::Readout.new.print_schedule( showings )

      print readout

    rescue => error
      puts error
    end
  end

  def self.ingest_file( file_name )
    begin
      movies = MovieScheduler::Movies.list_movies( file_name )
    rescue
      raise 'You must include an input file of movies'
    end
  end
end

file = ARGV[ 0 ]
weekday = ARGV[ 1 ]

MovieScheduler.schedule( file, weekday )
