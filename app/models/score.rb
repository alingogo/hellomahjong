class Score < ActiveRecord::Base
  attr_accessible :direction, :game_id, :participant_id, :points
  belongs_to :game
  belongs_to :participant

  DIRECTIONS = {"4" => 'E',
                "3" => 'S',
                "2" => 'W',
                "1" => 'N'}
end
