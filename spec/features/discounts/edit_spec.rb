require 'rails_helper'

describe 'Discount Edit Page' do
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

  describe "when I visit my discounts index view" do
    before(:each) do
      visit '/merchant'

      click_on 'Manage Discounts'
    end

  it 'can see an edit link next to each discount' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_link("Edit Discount")
    end

    within("#discount-#{@discount_2.id}") do
      expect(page).to have_link("Edit Discount")
    end
  end

  it 'can click the edit link and be taken to the edit discount view' do
    within("#discount-#{@discount_1.id}") do
      click_link("Edit Discount")
    end

    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")
    expect(page).to have_content("Edit Discount")
    expect(page).to have_field('name', with: "#{@discount_1.name}")
    expect(page).to have_field('minimum_qty', with: "#{@discount_1.minimum_qty}")
    expect(page).to have_field('percent_off', with: "#{@discount_1.percent_off}")
  end

  it 'can fill in a field with a valid input and submit changes' do
    within("#discount-#{@discount_1.id}") do
      click_link("Edit Discount")
    end

    fill_in 'Name', with: 'Black Friday Discount'
    click_on 'Update Discount'
  end

  it 'can submit discount changes and be redirected to discount index where it can see edited discount' do
    within("#discount-#{@discount_1.id}") do
      click_link("Edit Discount")
    end

    fill_in 'Name', with: 'Black Friday Discount'
    click_on 'Update Discount'
    expect(current_path).to eq('/merchant/discounts')

    within("#discount-#{@discount_1.id}") do
      expect(page).to have_content('Black Friday Discount')
    end
  end
end
 end
