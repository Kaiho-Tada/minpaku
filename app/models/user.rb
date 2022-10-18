class User < ApplicationRecord
  has_many :registered_rooms, class_name: "Room", foreign_key: "owner_id"
  has_many :reservations
  mount_uploader :avatar, AvatarUploader
  validates :name, length: {maximum: 50}, presence: true
  validates :email, length: {maximum: 500}, presence: true, uniqueness: true
  validates :introduction, length: {maximum: 300}
  validates :password, length: {maximum: 20, minimum: 6}, presence: true, uniqueness: true
end
