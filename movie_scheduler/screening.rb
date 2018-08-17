module MovieScheduler
  class Screening
    def initialize( movie )
      @movie         = movie
      @theater_hours = MovieScheduler::Theater.get_todays_hours
      @setup_time    = MovieScheduler::Theater.setup_time
      @interval      = MovieScheduler::Theater.interval
    end

    def run_time
      movie_run_time = ( @movie[ :run_time ] + @interval ).ceil
    end


    def screen_time_minutes
      open_at       = @theater_hours[ :open_at ] + @setup_time
      close_at      = @theater_hours[ :close_at ]
      screen_time   = ( ( close_at - open_at) * 60 )
    end

    def total_possible_screenings
      ( screen_time_minutes / run_time ).floor
    end
  end
end
