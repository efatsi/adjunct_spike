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
    self.utc_start = parse(input_start)
    self.utc_end   = parse(input_end)
  end

  private

  def parse(time)
    time_parser.utc(day, time)
  end

  def time_parser
    @time_parser ||= TimeParser.new(time_zone)
  end
end
