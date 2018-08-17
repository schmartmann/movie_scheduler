module MovieScheduler
  class Configuration
    def self.operating_hours
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

      operating_hours = {
        'Monday': standard_schedule,
        'Tuesday': standard_schedule,
        'Wednesday': standard_schedule,
        'Thursday': standard_schedule,
        'Friday': reduced_schedule,
        'Saturday': reduced_schedule,
        'Sunday': reduced_schedule
      }
    end
  end
end
