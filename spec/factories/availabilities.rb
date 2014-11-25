FactoryGirl.define do
  factory :availability do
    user
    day         1
    input_start "11 am"
    input_end   "4 pm"
    time_zone   "Mountain Time (US & Canada)"

    after(:build) do |availability|
      availability.calculate_utc_times
    end
  end
end
