require 'rails_helper'

describe 'Destroy a Discount' do
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
    @discount_1 = @merchant_1.discounts.create!(name: "Holiday Weekend 75%-Off", percent_off: 75)

    visit '/'
    click_on 'Login'

    fill_in 'Email Address', with: @merchant_user.email
    fill_in 'Password', with: 'password'

    click_button 'Login'
  end

  describe "when I visit my discounts index view" do
    before(:each) do
      visit '/merchant'

      click_on 'Manage Discounts'
  end

  it 'can see a delete button next to each discount'
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_button("Delete Discount")
    end

    within("#discount-#{@discount_2.id}") do
      expect(page).to have_button("Delete Discount")
    end
  end

  it 'can click discount delete button and index page will be refreshed with
  discount gone' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_button("Delete Discount")
    end

    expect(current_path).to eq('merchant/discounts')
    expect(current_path).to have_no_content("#{@discount_1.name}")
    expect(current_path).to have_no_content("#{@discount_1.percent_off}")
  end
end
