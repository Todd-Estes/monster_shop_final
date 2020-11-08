class Discount < ApplicationRecord
  belongs_to :merchant

  validates_presence_of :name,
                        :minimum_qty,
                        :percent_off

end
