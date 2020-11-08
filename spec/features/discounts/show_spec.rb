require "rails_helper"

describe "Discounts Show Page" do
  before(:each) do
    @merchant_1 = Merchant.create(name: 'Bobs Exotics',
                                   address: '100 AE ST',
                                   city: 'Denver',
                                   state: 'CO',
                                   zip: 80218)
    @merchant_user = @merchant_1.users.create(name: 'Bob',
                                              address: '100 AE ST',
                                              city: 'Denver',
                                              state: 'CO',
                                              zip: 80218,
                                              email: 'bob@example.com',
                                              password: 'password')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    @discount_1 = @merchant_1.discounts.create!(name: "5% Off Twenty or More", minimum_qty: 20, percent_off: 0.05)
    @discount_2 = @merchant_1.discounts.create!(name: "20% Off Five or More", minimum_qty: 5, percent_off: 0.20)

    visit '/root'
  end

  it "can visit show page and see discount information" do
    visit "/merchant/discounts/#{@discount_1.id}"

    expect(page).to have_content("Discount ID: #{@discount_1.id}")
    expect(page).to have_content("Minimum Quantity to Qualify: #{@discount_1.minimum_qty}")
    expect(page).to have_content("Discount Percentage: #{@discount_1.percent_off}")
  end
end
