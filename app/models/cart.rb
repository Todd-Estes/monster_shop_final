class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

#   def items
#   item_quantity = {}
#   @contents.each do |item_id,quantity|
#     item_quantity[Item.find(item_id)] = quantity
#   end
#   item_quantity
# end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    @contents.sum do |item_id, quantity|
      item = Item.find(item_id)
        if item.no_discounts?(quantity)
          subtotal_of(item.id)
        else
          subtotal_with_discounts(item, quantity)
        end
    end
  end

    def subtotal_with_discounts(item, quantity)
      discount = (item.highest_discount(quantity)).percent_off
      (item.apply_discount(self.subtotal_of(item.id), discount))
    end



  # def grand_total
  #   grand_total = 0.0
  #   @contents.each do |item_id, quantity|
  #     grand_total += Item.find(item_id).price * quantity
  #   end
  #   grand_total
  # end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end
end
