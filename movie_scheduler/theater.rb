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
      if movie[ :title ] = "The Proposal"
        # a movie has a run time
        # for each potential screening of a movie, we start at the end of the day
        # and subtract the run time from the total time left
        # until we run out of time

        closing_time = get_todays_hours[ :close_at ]
        opening_time = get_todays_hours[ :open_at ]

        screening = Screening.new( movie )

        remaining_hours = get_todays_hours[ :close_at ]

        total_run_time = screening.run_time

        show_times = []

        while remaining_hours > opening_time
          showing = remaining_hours -= total_run_time

          show_times.push(
            {
              title: movie[ :title ],
              run_time: total_run_time,
              raw_time: showing,
              pretty_time: convert_time( showing )
            }
          )
        end
        puts "#{ show_times[ 0 ] }"
      end
    end

    def self.humanize_time( int )
    end

    def self.build_movie_schedule( movie )
      schedule_screenings( movie )
    end

    def self.convert_time( int )
      suffix = 'A.M.'

      if int > 12
        suffix = 'P.M'
        int -= 12
      end

      string = int.to_s

      hours = string.split( '.' ).first.to_i
      minutes = ( ( int - hours ) * 60 ).ceil

      if minutes < 10
        minutes = "0#{ minutes }"
      else
        minutes.to_s
      end

      converted_time = "#{ hours }:#{ minutes } #{ suffix }"
    end
  end
end
