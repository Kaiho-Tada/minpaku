class Room < ApplicationRecord
    belongs_to :owner, class_name: "User"
    has_many :tickets
    has_many :reservations, dependent: :destroy
    mount_uploader :room_image, RoomImageUploader
    validates :name, length: {maximum: 50}, presence: true
    validates :place, length: {maximum: 50}, presence: true
    validates :introduction, length: {maximum: 100}
    validates :price, length: {maximum: 50}, presence: true
    validates :room_image, presence: true

    def registered_by?(user)
        return false unless user
        owner_id == user.id
    end
    def self.looks(kana, hira, roman)
        @rooms = Room.where("(name LIKE?) OR (name LIKE?) OR (name LIKE?)", "%#{kana}%", "%#{hira}%", "%#{roman}%")
    end
    def self.looks_exception(exception)
        @rooms = Room.where("name LIKE?", "%#{exception}%")
    end

    def self.looks_place(word)
        @rooms = Room.where("place LIKE?", "%#{word}%")
    end
end
