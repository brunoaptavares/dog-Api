class CreatePets < ActiveRecord::Migration[6.0]
  def change
    create_table :pets do |t|
      t.string :name, null: false
      t.string :breed, null: false
      t.references :client, foreign_key: true
      t.timestamps
    end
  end
end
