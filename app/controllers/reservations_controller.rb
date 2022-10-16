class ReservationsController < ApplicationController
    def index
        @reservations = Reservation.all
    end
    def create
        room = Room.find(params[:room_id])
        @reservation = current_user.reservations.build do |t|
            t.room = room
            t.number_people = params[:reservation][:number_people]
        end
        if @reservation.update(params.require(:reservation).permit(:start_at, :end_at))
            flash[:notice] = "以下の内容で予約しました"
            redirect_to room_reservation_path(room, current_user)
                        
        else
            @room = room
            @reservations = @room.reservations.where("end_at >?", Date.today).order(:start_at)
            render "rooms/show"
        end
    end
    def show
        @reservation = current_user.reservations.order(created_at: :desc).find_by(room_id: params[:room_id])
    end
    def destroy
        @reservation = current_user.reservations.find_by(room_id: params[:room_id])
        @reservation.destroy
        flash[:notice] = "この部屋の予約をキャンセルしました"
        redirect_to room_path(params[:room_id])
    end
end
