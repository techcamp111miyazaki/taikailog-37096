class Event < ApplicationRecord
  validates :event_title,   presence: true
  validates :place,         presence: true
  validates :prefecture_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :genre_id,      presence: true, numericality: { other_than: 1 , message: "can't be blank"}  
  validates :date,          presence: true
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :genre
end
