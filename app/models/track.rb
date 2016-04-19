class Track < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  validates :song_title, presence: true, length: {minimum: 3, maximum: 50}
  validates :author, presence: true, length: {minimum: 1, maximum: 30}

end