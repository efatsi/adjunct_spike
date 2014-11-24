class AvailabilityBuilder
  def self.build(params)
    new(params).build
  end

  def initialize(params)
    @params = params
  end

  def build
    Availability.new modified_params
  end

  private

  def modified_params
    @params.merge({
      utc_start: utc_start,
      utc_end:   utc_end
    })
  end

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
