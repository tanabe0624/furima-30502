class OrdersController < ApplicationController
  before_action :move_to_root_path, only: :index
  before_action :authenticate_user!, only: :index
  
  def index
    if user_signed_in? && current_user.id == @item.user.id
      redirect_to root_path 
    end
    @item = Item.find(params[:item_id]) #ordersのルーティングはネストされているから[:id]だけでなく、親のitemもくっつけて書く必要がある
    @address_info = AddressInfo.new
  end

  def create 
    @item = Item.find(params[:item_id])
    @address_info = AddressInfo.new(info_params)
    if @address_info.valid?
      pay_item
      @address_info.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render action: :index
    end
  end

  private
  def info_params
    params.require(:address_info).permit(:zip_code, :prefectures_id, :city, :street_number, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])  
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: info_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_root_path
    @item = Item.find(params[:item_id])
    if @item.order
      redirect_to root_path
    end
  end
end
