require 'rails_helper'

describe 'Discount Creation Form' do
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

      @discount_1 = @merchant_1.discounts.create!(name: "5% Off Twenty or More", minimum_qty: 20, percent_off: 0.05)
      @discount_2 = @merchant_1.discounts.create!(name: "20% Off Five or More", minimum_qty: 5, percent_off: 0.20)

      visit '/root'
    end

    describe "when I visit my discounts index view" do
      before(:each) do
        visit '/merchant'

        click_on 'Manage Discounts'
      end
    it 'can see a link to create new discounts' do
      expect(page).to have_link("Create New Discount")
    end

    it 'can click the Create New Discount link and be taken to New Discount form view' do
      click_link("Create New Discount")

      expect(current_path).to eq('/merchant/discounts/new')
      expect(page).to have_field('name')
      expect(page).to have_field('minimum_qty')
      expect(page).to have_field('percent_off')
    end

    it 'can fill out New Discount form, click submit and be taken back to discount index view' do
      click_link("Create New Discount")

      name = "10% Off Three or More"
      minimum_qty = 3
      percent_off = 0.10

      fill_in "name", with: name
      fill_in 'minimum_qty', with: minimum_qty
      fill_in 'percent_off', with: percent_off

      click_button "Create Discount"

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_content("10% Off Three or More")
      expect(page).to have_content(3)
      expect(page).to have_content(0.10)
    end

    it 'can fail to fill out all fields and be redirected to form view with an error message' do
      click_link("Create New Discount")
      click_button("Create Discount")

      expect(page).to have_content('No fields can be left empty')
      expect(current_path).to eq('/merchant/discounts/new')
    end
  end
end
