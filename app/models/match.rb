class Match < ApplicationRecord
  validates :turn_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :field_id, presence: true, numericality: { other_than: 1 , message: "can't be blank"}
  validates :order_number, presence: true, numericality: { only_integer: true, message: "input only half-numbers" }
  validates :player_name_1, presence: true
  validates :belongs_1, presence: true
  # validates :score_1, numericality: { message: "input only half-numbers" }
  # validates :score_2, numericality: { message: "input only half-numbers" }

  belongs_to :user
  belongs_to :event

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :turn
  belongs_to :field
end
