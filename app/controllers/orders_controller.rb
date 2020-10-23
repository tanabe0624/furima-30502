class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create, :move_to_root_path]
  before_action :move_to_root_path, only: :index
  before_action :authenticate_user!, only: :index

  def index
    @address_info = AddressInfo.new
  end

  def create 
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

  def set_item
    @item = Item.find(params[:item_id]) #ordersのルーティングはネストされているから[:id]だけでなく、親のitemもくっつけて書く必要がある
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
    return redirect_to root_path if @item.order || current_user.id == @item.user.id
  end
end
