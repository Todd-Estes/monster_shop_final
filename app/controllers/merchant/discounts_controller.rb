class Merchant::DiscountsController < Merchant::BaseController

def index
  @discounts = Discount.all
  @merchant = Merchant.find_by(params[:merchant_id])
end

def show
  @discount = Discount.find(params[:id])
end

def new

end

def create
  discount = current_user.merchant.discounts.create(discount_params)
  if discount.save
      redirect_to '/merchant/discounts'
  else
    flash[:error] = "No fields can be left empty"
      redirect_to '/merchant/discounts/new'
  end
end

def edit
end

def update
end

def destroy
end

  private
    def discount_params
      params.permit(:name, :minimum_qty, :percent_off)
    end
end
