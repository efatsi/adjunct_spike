class SubSearch < ActiveRecord::Base
  belongs_to :search

  def find_user_ids(time_zone)
    Availability.find_by_sql([
      %Q{
        SELECT a.user_id FROM availabilities a
        WHERE
          a.day        = ? AND
          a.utc_start <= ? AND
          a.utc_end   >= ?
        GROUP BY a.user_id
      }, day, time_zone.parse(input_start), time_zone.parse(input_end)
    ]).map(&:user_id)
  end
end
