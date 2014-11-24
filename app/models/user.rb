class User < ActiveRecord::Base
  has_many :availabilities

  def to_s
    name
  end
end
