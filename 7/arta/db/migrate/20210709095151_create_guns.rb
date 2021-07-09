class CreateGuns < ActiveRecord::Migration[5.2]
  def change
    create_table :guns do |t|
      t.string :name
      t.float :start_speed
      t.integer :min_angle
      t.integer :max_angle
      t.integer :bullet_count

      t.timestamps
    end
  end
end
