require 'rails_helper'

RSpec.describe Coupon do
  describe 'Relationships' do
    it {should belong_to :merchant}
  end
end
