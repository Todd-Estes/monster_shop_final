require 'rails_helper'

describe 'As a merchant user' do
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

    @coupon_1 = @merchant.coupons.create!(name: "Summer Deal 50%-Off", code: "50OFF", percent_off: 50)
    @coupon_2 = @merchant.coupons.create!(name: "Holiday Weekend 75%-Off", code: "75OFF", percent_off: 75, enabled: false)

    visit '/'
    click_on 'Login'

    fill_in 'Email Address', with: @merchant_user.email
    fill_in 'Password', with: 'password'

    click_button 'Login'
  end

  describe "when I visit my coupons index view" do
    before(:each) do
      visit '/merchant'

      click_on 'Manage Coupons'
  end

  it 'can see the name, code, percent_off, and enabled status' do
    within("#coupon-#{@coupon_1.id}") do
      expect(page).to have_link("#{coupon_1.name}")
      expect(page).to content("#{coupon_1.code}")
      expect(page).to content("#{coupon_1.percent_off}%")
      expect(page).to content("#{coupon_1.status}")
    end

      within("#coupon-#{@coupon_1.id}") do
        expect(page).to have_link("#{coupon_2.name}")
        expect(page).to content("#{coupon_2.code}")
        expect(page).to content("#{coupon_2.percent_off}%")
        expect(page).to content("#{coupon_2.status}")
      end
   end

   it "can click a coupon name and be linked to coupon show page" do
      click_link("#{coupon_1.name}")

      expect(current_path).to eq("merchant/#{coupon_1.id}")
   end
 end
end

   # it "can see a delete button next to each coupon" do
   #   within("#coupon-#{@coupon_1.id}") do
   #     expect(page).to have_content("Delete Coupon")
   #   end
   #
   #    within("#coupon-#{@coupon_1.id}") do
   #      expect(page).to have_content("Delete Coupon")
   #    end
   # end
