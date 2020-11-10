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

    @discount_1 = @merchant_1.discounts.create!(name: "5% Off Twenty or More", minimum_qty: 20, percent_off: 0.05)
    @discount_2 = @merchant_1.discounts.create!(name: "20% Off Five or More", minimum_qty: 5, percent_off: 0.20)

    visit '/root'
  end

  describe "when I visit my discounts index view" do
    before(:each) do
      visit '/merchant'

      click_on 'Manage Discounts'
  end

  it 'can see the name, minimum_qty, percent_off' do
    within("#discount-#{@discount_1.id}") do
      expect(page).to have_link("#{@discount_1.name}")
      expect(page).to have_content("Minimum Quantity to Qualify: #{@discount_1.minimum_qty}")
      expect(page).to have_content("Percent Off: #{@discount_1.percent_off}%")
    end

      within("#discount-#{@discount_2.id}") do
        expect(page).to have_link("#{@discount_2.name}")
        expect(page).to have_content("Minimum Quantity to Qualify: #{@discount_2.minimum_qty}")
        expect(page).to have_content("Percent Off: #{@discount_2.percent_off}%")
      end
   end

   it "can click a discount name and be linked to discount show page" do
      click_link("#{@discount_1.name}")

      expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")
   end
 end
end
