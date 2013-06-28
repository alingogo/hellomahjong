class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :meeting_id
      t.string :table
      t.integer :number
      t.string :status

      t.timestamps
    end
  end
end
