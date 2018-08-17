require 'date'

module MovieScheduler
  class Theater
    def initialize
      @setup_time       = 60
      @change_over_time = 35
    end

    def current_day
      current_day = Date.today.strftime("%A")
    end

    def operating_hours
      # Monday - Thursday 8:00am - 11:00pm
      # Friday - Sunday 10:30am - 11:30pm
      standard_schedule = {
        open_at: 8,
        close_at: 23
      }

      reduced_schedule = {
        open_at: 10.5,
        close_at: 23.5
      }

      if [ 'Friday', 'Saturday', 'Sunday' ].include?( current_day )
        reduced_schedule
      else
        standard_schedule
      end
    end
  end
end
