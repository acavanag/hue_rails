class CreateLights < ActiveRecord::Migration
  def change
    create_table :lights do |t|
      t.string :name
      t.string :key

      t.timestamps
    end
  end
end
