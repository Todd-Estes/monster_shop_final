require 'rails_helper'

describe 'Coupon Creation Form' do
    before (:each) do
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

    it 'can see a link to create new coupons' do
      expect(page).to have_link("Create New Coupon")
    end

    it 'can click the Create New Coupon link and be taken to New Coupon form view' do
      click_link("Create New Coupon")

      expect(current_path).to eq('/merchant/coupons/new')
      expect(page).to have_field('Name')
      expect(page).to have_field('Code')
      expect(page).to have_field('Percent Off')
    end

    it 'can fill out New Coupon form, click submit and be taken back to coupon index view' do
      click_link("Create New Coupon")

      fill_in 'Name', with :"Veterans Day"
      fill_in 'Code', with :"VETS"
      fill_in 'Code', with : "5"

      click_button "Create Coupon"

      expect(current_path).to eq('merchant/coupons')
    end

    it 'can fail to fill out all fields and be redirected to form view with an error message' do
      click_link("Create New Coupon")

      fill_in 'Name', with :"Veterans Day"
      fill_in 'Code', with :"VETS"

      expect(current_path).to eq('/merchants/coupons/new')
      expect(page).to have_content('No fields can be left empty')
    end
  end
end
