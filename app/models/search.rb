class Search < ActiveRecord::Base
  has_many :sub_searches

  accepts_nested_attributes_for :sub_searches

  def results
    if sub_searches.any?
      Availability.where("day = ? AND utc_start <= ? && utc_end >= ?", day, utc_start, utc_end)
    end
  end

  def day
    sub_search.day
  end

  def utc_start
    time_zone_object.parse(sub_search.input_start)
  end

  def utc_end
    time_zone_object.parse(sub_search.input_end)
  end

  def time_zone_object
    @time_zone ||= ActiveSupport::TimeZone.new(time_zone)
  end

  def sub_search
    @sub_search ||= sub_searches.first
  end
end

# User.find_by_sql %Q{
#   SELECT user.* FROM users user, availabilities avail, availabilities avail2
#   WHERE (
#       avail.user_id = user.id  AND
#       avail.day     = 2
#     ) AND
#     (
#       avail2.user_id = user.id AND
#       avail2.day     = 5
#     )
#   GROUP BY user.id
# }
