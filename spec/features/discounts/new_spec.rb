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

    it 'can see a link to create new discounts' do
      expect(page).to have_link("Create New Discount")
    end

    it 'can click the Create New Discount link and be taken to New Discount form view' do
      click_link("Create New Discount")

      expect(current_path).to eq('/merchant/discounts/new')
      expect(page).to have_field('Name')
      expect(page).to have_field('Code')
      expect(page).to have_field('Percent Off')
    end

    it 'can fill out New Discount form, click submit and be taken back to discount index view' do
      click_link("Create New Discount")

      fill_in 'Name', with :"Veterans Day"
      fill_in 'Code', with :"VETS"
      fill_in 'Code', with : "5"

      click_button "Create Discount"

      expect(current_path).to eq('merchant/discounts')
    end

    it 'can fail to fill out all fields and be redirected to form view with an error message' do
      click_link("Create New Discount")

      fill_in 'Name', with :"Veterans Day"
      fill_in 'Code', with :"VETS"

      expect(current_path).to eq('/merchants/discounts/new')
      expect(page).to have_content('No fields can be left empty')
    end
  end
end
