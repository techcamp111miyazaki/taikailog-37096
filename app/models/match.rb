class Match < ApplicationRecord
  validates :turn_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :field_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :order_number, presence: true
  validates :player_name_1, presence: true
  validates :belongs_1, presence: true

  belongs_to :user
  belongs_to :event

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :turn
  belongs_to :field
end
