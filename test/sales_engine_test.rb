require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => './test/fixtures/items_truncated.csv',
      :merchants => './test/fixtures/merchants_truncated.csv',
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_has_attributes
    assert_equal './test/fixtures/items_truncated.csv', @sales_engine.item_path
    assert_equal './test/fixtures/merchants_truncated.csv', @sales_engine.merchant_path
  end

  def test_it_has_items
    assert_instance_of Array, @sales_engine.items
    assert_equal 4, @sales_engine.items.length
  end

  def test_it_can_create_a_merchant_collection
    assert_instance_of MerchantCollection, @sales_engine.merchant_collection
  end
end
