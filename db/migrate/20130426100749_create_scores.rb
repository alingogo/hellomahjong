class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :game_id
      t.integer :participant_id
      t.integer :points
      t.integer :direction

      t.timestamps
    end
  end
end
