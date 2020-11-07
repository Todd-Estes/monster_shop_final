class Merchant::DiscountsController < Merchant::BaseController

def index
  @discounts = Discount.all
  @merchant = Merchant.find_by(params[:merchant_id])
end

def show
  @discount = Discount.find(params[:id])
end

def create
end

def edit
end

def update
end

def destroy
end

  private
    def discount_params
      params.permit(:name, :percent_off)
    end
end
