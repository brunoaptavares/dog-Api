class CreateDogWalkings < ActiveRecord::Migration[6.0]
  def change
    create_table :dog_walkings do |t|
      t.string :status, default: 'scheduled'
      t.datetime :schedule_date, null: false
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :duration, null: false
      t.string :latitude, null: false
      t.string :longitude, null: false
      t.datetime :ini_date
      t.datetime :end_date
      t.timestamps
    end

    add_index :dog_walkings, :status
  end
end
