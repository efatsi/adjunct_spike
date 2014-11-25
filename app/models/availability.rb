class Availability < ActiveRecord::Base
  belongs_to :user

  DAYS = {
    "1" => "Sunday",
    "2" => "Monday",
    "3" => "Tuesday",
    "4" => "Wednesday",
    "5" => "Thursday",
    "6" => "Friday",
    "7" => "Saturday"
  }

  def self.new_and_calculate(params)
    new(params).tap do |availability|
      availability.calculate_utc_times
    end
  end

  def calculate_utc_times
    self.utc_start = parsed_utc_start
    self.utc_end   = parsed_utc_end
  end

  private

  def parsed_utc_start
    time_parser.utc(day, input_start)
  end

  def parsed_utc_end
    time_parser.utc(day, input_end)
  end

  def time_parser
    @time_parser = TimeParser.new(time_zone)
  end
end
