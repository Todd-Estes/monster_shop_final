class CreateDiscounts < ActiveRecord::Migration[5.2]
  def change
    create_table :discounts do |t|
      t.string :name
      t.integer :minimum_qty
      t.float :percent_off
      t.references :merchant, foreign_key: true
    end
  end
end
