class CreateDogWalkingPetsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :dog_walkings, :pets do |t|
      t.index :dog_walking_id
      t.index :pet_id
    end
  end
end
