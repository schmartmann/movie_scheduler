require 'date'

module MovieScheduler
  class Theater
    def self.setup_time
      @setup_time = 1
    end

    def self.interval
      @interval = ( 35.to_f / 60.to_f )
    end

    def self.current_day( current_day = nil )
      unless current_day
        current_day = Date.today.strftime( '%A' ).to_sym
      else
        current_day.capitalize.to_sym
      end
    end

    def self.get_todays_hours( weekday )
      day = current_day( weekday )
      MovieScheduler::Configuration.operating_hours[ day ]
    end

    def self.max_hours_per_screen
      open_at       = get_todays_hours[ :open_at ] + setup_time
      close_at      = get_todays_hours[ :close_at ]
      screen_time   = ( close_at - open_at )
    end

    def self.schedule_screenings( movie, weekday )
      closing_time = get_todays_hours( weekday )[ :close_at ]
      opening_time = get_todays_hours( weekday )[ :open_at ]

      screening = Screening.new( movie )

      remaining_hours = closing_time

      total_run_time = screening.run_time

      show_times = []

      while remaining_hours > ( opening_time + total_run_time )
        show_time = ( remaining_hours - total_run_time )

        rounded_time, humanized_time = humanize_time( show_time )

        rounded_end_time, humanized_end_time = humanize_time( show_time + movie[ :converted_run_time ] )

        show_times.push( { starts_at: humanized_time, ends_at: humanized_end_time } )

        remaining_hours = remaining_hours - ( remaining_hours - rounded_time )
      end

      schedule = {
        title: movie[ :title ],
        rating: movie[ :rating ],
        absolute_run_time: movie[ :absolute_run_time ],
        show_times: show_times.reverse
      }
    end

    def self.humanize_time( int )
      rounded_time = round_time( int )
      humanized_time = convert_time( rounded_time )
      [ rounded_time, humanized_time ]
    end


    def self.round_time( int )
      hours, minutes = int.divmod( 1 )
      minutes *= 60
      minutes = minutes.ceil

      rounding_points = [ 0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60 ]

      # this should round the timing up to the nearest human-friendly minute
      rounding_points.each_with_index do | int, index |
        if minutes > int && minutes < rounding_points[ index + 1 ]
          minutes += rounding_points[ index + 1 ] - minutes
        end
      end

      minutes_decimal = ( minutes.to_f / 60 )

      ( hours + minutes_decimal )
    end

    def self.convert_time( int )
      # full credit to this post for this very handy solution
      # https://stackoverflow.com/questions/22904532/in-ruby-conversion-of-float-integer-into-h-m-s-time
      sec = ( int * 3600 ).to_i
      min, sec = sec.divmod( 60 )
      hour, min = min.divmod( 60 )
      "%02d:%02d:%02d" % [ hour, min, sec ]
    end

    def self.build_movie_schedule( movie, weekday )
      schedule_screenings( movie, weekday )
    end
  end
end
