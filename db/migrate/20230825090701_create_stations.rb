class CreateStations < ActiveRecord::Migration[6.0]
  def change
    create_table :stations do |t|
      t.string :train_line
      t.string :station_name
      t.integer :walking_time

      t.timestamps
    end
  end
end
