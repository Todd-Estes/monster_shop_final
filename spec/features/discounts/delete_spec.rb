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

    it 'can see a delete button next to each discount' do
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
        click_button("Delete Discount")
      end

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_no_content("#{@discount_1.name}")
      expect(page).to have_no_content("#{@discount_1.percent_off}")

      within("#discount-#{@discount_2.id}") do
        click_button("Delete Discount")
      end

      expect(page).to have_no_content("#{@discount_2.name}")
      expect(page).to have_no_content("#{@discount_2.percent_off}")
    end
  end
end
