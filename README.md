This app will return a formatted list of movie show times.

To return a printed list of movie show times for today to the console, run `ruby movie_scheduler.rb <your_file>.txt`

Example:
```
ruby movie_scheduler input.txt
```

Alternatively, you can supply an optional parameter to specify show times for a given weekday.

Example:
```
ruby movie_scheduler input.txt sunday
```

Schedule configurations are in `movie_scheduler/configuration.rb`.
Theater configurations --such as setup_time  or interval between movies-- are in `movie_schedule/theater.rb`.

To run tests, simply return `rspec`.

NOTES:

I chose to build this app in Ruby because of its object-oriented nature. Syntactically, it made sense to me to organize the various components of this app into objects, such as a Theater, a Screening, or a Movie.

Also, my familiarity with RSpec as a testing suite reinforced my decision to use Ruby. 
