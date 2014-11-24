class CreateSubSearches < ActiveRecord::Migration
  def change
    create_table :sub_searches do |t|
      t.integer :day
      t.string :input_start
      t.string :input_end
      t.integer :search_id

      t.timestamps
    end
  end
end
