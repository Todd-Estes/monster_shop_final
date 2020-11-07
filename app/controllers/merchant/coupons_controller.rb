class Merchant::DiscountsController < Merchant::BaseController

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
    def discount_params
      params.permit(:name, :percent_off)
    end
end
