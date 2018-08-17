require 'date'

module MovieScheduler
  class Theater
    def self.setup_time
      @setup_time = 1
    end

    def self.interval
      @interval = ( 35.to_f / 60.to_f )
    end

    def self.current_day
      current_day = Date.today.strftime( '%A' ).to_sym
    end

    def self.get_todays_hours
      MovieScheduler::Configuration.operating_hours[ current_day ]
    end

    def self.max_hours_per_screen
      open_at       = get_todays_hours[ :open_at ] + setup_time
      close_at      = get_todays_hours[ :close_at ]
      screen_time   = ( close_at - open_at )
    end

    def self.schedule_screenings( movie )
      # a movie has a run time
      # for each potential screening of a movie, we start at the end of the day
      # and subtract the run time from the total time left
      # until we run out of time

      screening = Screening.new( movie )

      max_hours = max_hours_per_screen

      while max_hours >= screening.run_time
        max_hours -= screening.run_time
        # puts "showing at #{ humanize_time( max_hours ) }"
        puts "run time #{ screening.run_time } | max_hours #{ max_hours }"
      end
    end

    def self.humanize_time( int )
      ( get_todays_hours[ :close_at ] - int )
    end

    def self.build_movie_schedule( movie )
      schedule_screenings( movie )
    end
  end
end
