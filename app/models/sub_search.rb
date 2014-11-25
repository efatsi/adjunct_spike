class SubSearch < ActiveRecord::Base
  validates :day, :input_start, :input_end, :presence => true

  belongs_to :search

  def find_user_ids(time_parser)
    Availability.find_by_sql([
      %Q{
        SELECT a.user_id FROM availabilities a
        WHERE
          a.utc_start <= ? AND
          a.utc_end   >= ?
        GROUP BY a.user_id
      }, time_parser.utc(day, input_start), time_parser.utc(day, input_end)
    ]).map(&:user_id)
  end
end
