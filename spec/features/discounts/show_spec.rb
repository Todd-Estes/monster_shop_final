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

    @discount_1 = @merchant_1.discounts.create!(name: "Summer Deal 50%-Off", percent_off: 50)

    visit '/'
    click_on 'Login'

    fill_in 'Email Address', with: @merchant_user.email
    fill_in 'Password', with: 'password'

    click_button 'Login'
  end

  it "can visit show page and see discount information" do
    visit "/merchant/discounts/#{@discount_1.id}"

    expect(page).to have_content("#{@discount_1.id}")
    expect(page).to have_content("#{@discount_1.code}")
    expect(page).to have_content("#{@discount_1.percent_off}")
  end
end