module MovieScheduler
  class Readout
    def build_date_header
      weekday = MovieScheduler::Theater.current_day.to_s

      time = Time.now

      "#{ weekday } #{ time.month }/#{ time.day }/#{ time.year } \n"
    end

    def build_movie_header( movie )
      "\n#{ movie[ :title ] } - Rated: #{ movie[ :rating ] }, #{ movie[ :absolute_run_time ] } \n"
    end

    def build_show_times_list( movie )
      list = ''

      movie[ :show_times ].each do | time |
        list.concat( "  #{ time[ :starts_at ] } - #{ time[ :ends_at ] }\n")
      end

      list
    end

    def build_movie_details( movie )
      header = build_movie_header( movie )
      shows = build_show_times_list( movie )
      header.concat( shows )
    end

    def print_schedule( showings )
      date_header = build_date_header
      movies = []

      showings.each do | showing |
        movies.push( build_movie_details( showing ) )
      end

      movies = movies.join
      final_schedule = date_header.concat( movies )

      print final_schedule
    end
  end
end
