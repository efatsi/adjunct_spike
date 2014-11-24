class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :time_zone

      t.timestamps
    end
  end
end
