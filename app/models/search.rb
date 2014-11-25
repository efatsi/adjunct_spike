class Search < ActiveRecord::Base
  has_many :sub_searches, :dependent => :destroy
  accepts_nested_attributes_for :sub_searches, :allow_destroy => true

  def results
    return [] if sub_searches.none?

    user_id_arrays = sub_searches.map do |sub_search|
      sub_search.find_user_ids(time_zone_object)
    end

    user_ids = user_id_arrays.first.select do |user_id|
      user_id_arrays.all?{ |array| array.include?(user_id) }
    end

    User.find(user_ids)
  end

  def time_zone_object
    @time_zone ||= ActiveSupport::TimeZone.new(time_zone)
  end
end
