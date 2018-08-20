RSpec.describe MovieScheduler::Readout, '#build_movie_header' do
  context "with valid movie" do
    it "returns a properly formatted header" do
      movie = {
        title: 'blip blop',
        release_year: '2018',
        rating: 'R',
        absolute_run_time: '1:48',
        converted_run_time: MovieScheduler::Movies.convert_runtime( "1:48 \n" )
      }

      header = MovieScheduler::Readout.new.build_movie_header( movie )

      expect( header ).to eq "\nblip blop - Rated: R, 1:48 \n"
    end
  end
end

RSpec.describe MovieScheduler::Readout, '#build_date_header' do
  context "with valid date" do
    it "returns a properly formatted date header" do
      header = MovieScheduler::Readout.new.build_date_header

      weekdays = {
        1 => 'Monday',
        2 => 'Tuesday',
        3 => 'Wednesday',
        4 => 'Thursday',
        5 => 'Friday',
        6 => 'Saturday',
        7 => 'Sunday',
      }

      time = Time.now
      weekday = weekdays[ time.wday ]

      expect( header ).to eq "#{ weekday } #{ time.month }/#{ time.day }/#{ time.year } \n"
    end
  end
end

RSpec.describe MovieScheduler::Readout, '#build_show_times_list' do
  context "with valid movie" do
    it "returns a properly formatted list of show times" do
      movie = {
        title: 'blip blop',
        release_year: '2018',
        rating: 'R',
        absolute_run_time: '1:48',
        converted_run_time: MovieScheduler::Movies.convert_runtime( "1:48 \n" )
      }

      movie = MovieScheduler::Theater.build_movie_schedule( movie )

      list = MovieScheduler::Readout.new.build_show_times_list( movie )

      expected_list = "  09:00:00 - 10:50:00\n  11:20:00 - 13:10:00\n  13:40:00 - 15:30:00\n  16:00:00 - 17:45:00\n  18:20:00 - 20:10:00\n  20:40:00 - 22:30:00\n"

      expect( list ).to eq expected_list
    end
  end
end

RSpec.describe MovieScheduler::Readout, '#build_movie_details' do
  context "with valid movie" do
    it "returns a properly formatted movie schedule" do
      movie = {
        title: 'blip blop',
        release_year: '2018',
        rating: 'R',
        absolute_run_time: '1:48',
        converted_run_time: MovieScheduler::Movies.convert_runtime( "1:48 \n" )
      }

      movie = MovieScheduler::Theater.build_movie_schedule( movie )

      movie_schedule = MovieScheduler::Readout.new.build_movie_details( movie )

      expected_schedule = "\nblip blop - Rated: R, 1:48 \n  09:00:00 - 10:50:00\n  11:20:00 - 13:10:00\n  13:40:00 - 15:30:00\n  16:00:00 - 17:45:00\n  18:20:00 - 20:10:00\n  20:40:00 - 22:30:00\n"

      expect( movie_schedule ).to eq expected_schedule
    end
  end
end
