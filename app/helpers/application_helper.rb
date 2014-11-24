module ApplicationHelper
  def all_time_zones
    [
      ["Eastern", "Eastern Time (US & Canada)"],
      ["Central", "Central Time (US & Canada)"],
      ["Mountain", "Mountain Time (US & Canada)"],
      ["Arizona", "Arizona"]
    ]
  end

  def day_name(day)
    Availability::DAYS[day.to_s]
  end
end
