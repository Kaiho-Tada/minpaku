class RoomsController < ApplicationController
    skip_before_action :authenticate, only: [:index]
    before_action :ensure_correct_user, only: [:edit, :update, :destroy]

    def index
        @rooms = Room.all
    end
    def new
        @room = current_user.registered_rooms.build
    end

    def create
        @room = current_user.registered_rooms.build(params.require(:room).permit(:name, :place, :introduction, :price, :room_image))
        if @room.save
            flash[:notice] = "ルームを登録しました"
            redirect_to @room
        else
            render "rooms/new"
        end
    end

    def show
        @room = Room.find(params[:id])
        @current_user_reservation = current_user.reservations.find_by(id: params[:room_id])
        @reservations = @room.reservations.where("end_at >?", Time.zone.now).order(:start_at)
        @reservation = Reservation.new
    end

    def current_user_registered_show
        @rooms = Room.where(owner_id: current_user.id)
        @reservation = Reservation.new
    end

    def edit
        @room = current_user.registered_rooms.find(params[:id])
    end

    def update
        @room = current_user.registered_rooms.find(params[:id])
        if @room.update(params.require(:room).permit(:name, :place, :introduction, :price, :room_image))
            flash[:notice] = "ルーム情報を更新しました"
            redirect_to @room
        else
            render "rooms/edit"
        end
    end

    def destroy
        @room = current_user.registered_rooms.find(params[:id])
        @room.destroy
        flash[:notice] = "削除しました"
        redirect_to rooms_path
    end
    
    def reservation_page
        @rooms = Room.all
        @reservation = Reservation.new
    end
    def ensure_correct_user
        @room = Room.find(params[:id])
        if @room.owner_id != current_user.id
            flash[:notice] = "権限がありません"
            redirect_to root_path
        end
    end
end
