class CreatePresets < ActiveRecord::Migration
  def change
    create_table :presets do |t|
      t.string :brightness
      t.string :saturtion
      t.string :hue

      t.timestamps
    end
  end
end
