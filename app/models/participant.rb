class Participant < ActiveRecord::Base
  attr_accessible :meeting_id, :name
  belongs_to :meeting
  has_many :scores
end
