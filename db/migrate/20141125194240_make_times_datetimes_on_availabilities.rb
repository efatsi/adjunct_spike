class MakeTimesDatetimesOnAvailabilities < ActiveRecord::Migration
  def up
    change_column :availabilities, :utc_start, :datetime
    change_column :availabilities, :utc_end,   :datetime
  end

  def down
    change_column :availabilities, :utc_start, :time
    change_column :availabilities, :utc_end,   :time
  end
end
