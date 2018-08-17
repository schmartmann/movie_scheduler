require 'date'

module MovieScheduler
  class Theater
    def self.setup_time
      @setup_time = 1
    end

    def self.interval
      @interval   = ( 35.to_f / 60.to_f )
    end

    def self.current_day
      current_day = Date.today.strftime( '%A' ).to_sym
    end

    def self.get_todays_hours
      MovieScheduler::Configuration.operating_hours[ current_day ]
    end

    def self.schedule_screenings( movie )
      # a movie has a run time
      # for each potential screening of a movie, we start at the end of the day
      # and subtract the run time from the total time left
      # until we run out of time
      screening = Screening.new( movie )

      total_possible_screenings = screening.total_possible_screenings

      available_screentime = screening.screen_time_minutes

      total_possible_screenings.times do
        current_screening = available_screentime -= screening.run_time
        humanize_screening = ( ( screening.screen_time_minutes - current_screening ) / screening.screen_time_minutes )
        puts " #{ movie[ :title ] } showing at #{ humanize_screening }"
      end
    end

    def self.build_movie_schedule( movie )
      schedule_screenings( movie )
    end
  end
end
