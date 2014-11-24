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
end
