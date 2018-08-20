RSpec.describe MovieScheduler::Theater, '#round_time' do
  context "time is a decimal" do
    it "rounds time up or down to print as convenient time" do
      time = 20.11
      rounded_time = MovieScheduler::Theater.round_time( time )
      expect( rounded_time ).to eq 20.166666666666668
    end
  end
end

RSpec.describe MovieScheduler::Theater, '#convert_time' do
  context "time is a decimal" do
    it "returns a human-friendly time" do
      time = 20.166666666666668
      convert_time = MovieScheduler::Theater.convert_time( time )
      expect( convert_time ).to eq "20:10:00"
    end
  end
end

RSpec.describe MovieScheduler::Theater, '#humanize_time' do
  context "time is a decimal" do
    it "returns array with rounded_time & humanized_time" do
      time = 20.166666666666668
      rounded_time, humanized_time = MovieScheduler::Theater.humanize_time( time )
      expect( rounded_time ).to eq 20.25
      expect( humanized_time ).to eq "20:15:00"
    end
  end
end

RSpec.describe MovieScheduler::Theater, '#schedule_screenings' do
  context "with a valid movie" do
    it "returns array of show times" do
      movie = {
        title: 'blip blop',
        release_year: '2018',
        rating: 'R',
        absolute_run_time: '1:48',
        converted_run_time: MovieScheduler::Movies.convert_runtime( "1:48 \n" )
      }

      schedule = MovieScheduler::Theater.schedule_screenings( movie )
      expect( schedule[ :show_times ].length ).to eq 6
      expect( schedule[ :show_times ].last[ :ends_at ] ).to eq "22:30:00"
    end
  end
end
