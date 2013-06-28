class Game < ActiveRecord::Base
  attr_accessible :meeting_id, :number, :status, :table
  belongs_to :meeting
  has_many :scores
end
