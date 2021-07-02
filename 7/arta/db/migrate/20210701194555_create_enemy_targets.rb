class CreateEnemyTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :enemy_targets do |t|
      t.string :name
      t.integer :distance
      t.integer :max_radius

      t.timestamps
    end
  end
end
