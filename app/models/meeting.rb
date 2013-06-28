class Meeting < ActiveRecord::Base
  attr_accessible :creator, :description, :passwd, :title
  has_many :games
  has_many :participants
end
