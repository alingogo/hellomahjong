class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :passwd
      t.string :title
      t.string :description
      t.string :creator

      t.timestamps
    end
  end
end
