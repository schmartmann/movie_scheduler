module MovieScheduler
  class Screening
    def initialize( movie )
      @movie         = movie
      @interval      = MovieScheduler::Theater.interval
    end

    def run_time
      movie_run_time = ( @movie[ :converted_run_time ] + @interval )
    end

    def total_possible_screenings
      ( available_screen_time / run_time )
    end
  end
end
