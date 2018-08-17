module MovieScheduler
  class Movies
    def self.list_movies( file_name )
      movies = []
      text = File.readlines( file_name ).each_with_index do | line, index |
        unless index == 0
          line_arr = line.split( ', ' )

          movie = {
            title: line_arr[ 0 ],
            release_year: line_arr[ 1 ],
            rating: line_arr[ 2 ],
            run_time: convert_runtime( line_arr[ 3 ] )
          }

          movies.push( movie )
        end
      end

      movies
    end

    def self.convert_runtime( run_time )
      run_time_arr = run_time.gsub!( /\n/, '' ).split( ':' )
      hours = ( run_time_arr[ 0 ].to_i * 60 )
      minutes = run_time_arr[ 1 ].to_i

      total_runtime = hours + minutes
    end
  end
end
