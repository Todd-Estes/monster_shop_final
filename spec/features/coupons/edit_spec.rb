require 'rails_helper'

describe 'Coupon Edit Page' do
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

    @coupon_1 = @merchant_1.coupons.create!(name: "Summer Deal 50%-Off", code: "50OFF", percent_off: 50)
    @coupon_2 = @merchant_1.coupons.create!(name: "Holiday Weekend 75%-Off", code: "75OFF", percent_off: 75, enabled: false)

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

  it 'can see an edit link next to each coupon'
    within("#coupon-#{@coupon_1.id}") do
      expect(page).to have_link("Edit Coupon")
    end

    within("#coupon-#{@coupon_2.id}") do
      expect(page).to have_link("Edit Coupon")
    end
  end

  it 'can click the edit link and be taken to the edit coupon view' do
    within("#coupon-#{@coupon_1.id}") do
      click_link("Edit Coupon")
    end

    expect(current_path).to eq('merchant/coupons/edit')
    expect(page).to have_content("Edit Coupon")
    expect(page).to have_field('Name', with: @coupon_1.name)
    expect(page).to have_field('Code', with: @coupon_1.code)
    expect(page).to have_field('Percent Off', with: @coupon_1.discount)
  end

  it 'can fill in a field with a valid input and submit changes' do
    within("#coupon-#{@coupon_1.id}") do
      click_link("Edit Coupon")
    end

    fill_in 'Name', with: 'Black Friday Coupon'
    click_on 'Update Coupon'
  end

  it 'can submit coupon changes and be redirected to coupon index where it can see edited coupon' do
    within("#coupon-#{@coupon_1.id}") do
      click_link("Edit Coupon")
    end

    fill_in 'Name', with: 'Black Friday Coupon'
    click_on 'Update Coupon'
    expect(current_path).to eq('/merchant/coupons')

    within("#coupon-#{@coupon_1.id}") do
      expect(page).to have_content('Black Friday Coupon')
    end
  end
end
