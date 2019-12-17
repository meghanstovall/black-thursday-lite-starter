require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 1099,
      :merchant_id => 2
    })

    @items = Item.from_csv('./test/fixtures/items_truncated.csv')
    @csv_item = @items[2]
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_attributes
    assert_equal 1, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal 1099, @item.unit_price
    assert_equal 2, @item.merchant_id
  end

  def test_it_can_create_items_from_csv
    assert_instance_of Item, @csv_item
    assert_equal 263396013, @csv_item.id
    assert_equal "Free standing Woden letters", @csv_item.name
    assert_equal "Free standing wooden letters\n\n15cm\n\nAny colours", @csv_item.description
    assert_equal 700, @csv_item.unit_price
    assert_equal 12334185, @csv_item.merchant_id
  end

  def test_it_can_find_by_id
    assert_equal @csv_item, Item.find(263396013)
  end

  def test_it_can_find_all_items_where_merchant_id
    second_merchant_item = @items.first
    third_merchant_item = @items[1]
    assert_equal [second_merchant_item, third_merchant_item, @csv_item], Item.where(12334185)
  end
end
