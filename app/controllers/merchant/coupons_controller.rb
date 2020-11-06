class Merchant::CouponsController < Merchant::BaseController

def index
end

def show
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
    def coupon_params
      params.permit(:name, :code, :percent_off)
    end
end
