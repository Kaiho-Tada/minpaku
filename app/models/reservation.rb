class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :number_people, presence: true
  validate :start_at_should_be_before_end_at
  validate :start_at_and_end_at_not_dublicate
  validate :start_at_should_be_today_or_after_today
  private
  def start_at_should_be_before_end_at
    return unless start_at && end_at
    if start_at >= end_at
      errors.add(:start_at, "は終了時間よりも前に設定してください")
    end
  end

  def start_at_and_end_at_not_dublicate
    return unless start_at && end_at
    room = Room.find(self.room_id)
    if room.reservations.where("(end_at >?) AND (?> start_at)", "#{start_at}", "#{end_at}") == Reservation.none
      return
    else
      errors.add(:start_at, "または終了日には予約が入っています") 
    end
  end

  def start_at_should_be_today_or_after_today
    return unless start_at
    yesterday = Date.today - 1
    if start_at < yesterday
      errors.add(:start_at, "は今日以降に選択してください")
    end
    
  end
end
