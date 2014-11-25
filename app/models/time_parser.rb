class TimeParser

  def initialize(time_zone)
    @time_zone = ActiveSupport::TimeZone.new(time_zone)
  end

  # accepts day   as 1..7
  # accepts input as "hh:mm am/pm"
  def utc(day, input)
    @time_zone.parse(date_for(day) + " " + input)
  end

  private

  def date_for(day)
    # return a date in the year 2000
    # 2000 is an arbitrary year, but all times need to
    # be stored and compared with on equal terms

    {
      "1" => "2000-1-2", # sunday
      "2" => "2000-1-3", # monday
      "3" => "2000-1-4", # tuesday
      "4" => "2000-1-5", # wednesday
      "5" => "2000-1-6", # thursday
      "6" => "2000-1-7", # friday
      "7" => "2000-1-8"  # saturday
    }[day.to_s]
  end

end
