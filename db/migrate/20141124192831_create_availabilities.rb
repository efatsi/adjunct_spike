class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.integer :day
      t.time :utc_start
      t.time :utc_end
      t.string :input_start
      t.string :input_end
      t.string :time_zone
      t.integer :user_id

      t.timestamps
    end
  end
end
