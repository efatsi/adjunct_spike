class AvailabilitySearch
  def initialize(params)
    @params = params
  end

  def results
    Availability.where("day = ? AND utc_start < ? && utc_end > ?", @params[:day], utc_start, utc_end)
  end

  private

  def utc_start
    time_zone.parse(@params[:input_start])
  end

  def utc_end
    time_zone.parse(@params[:input_end])
  end

  def time_zone
    @time_zone ||= ActiveSupport::TimeZone.new(@params[:time_zone])
  end
end
