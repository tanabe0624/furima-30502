class OrdersController < ApplicationController

  def index
    @item = Item.find(params[:item_id]) #ordersのルーティングはネストされているから[:id]だけでなく、親のitemもくっつけて書く必要がある
    @address_info = AddressInfo.new
  end

  def create 
    @address_info = AddressInfo.new(info_params)
    if @address_info.valid?
      @address_info.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private
  def info_params
    params.require(:address_info).permit(:zip_code, :prefectures_id, :city, :street_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])  
  end
end
