require 'test_helper'

class PLIbanFormatterTest < ActiveSupport::TestCase
  test "raising exception when number has wrong size" do
    assert_raise PlIbanFormatter::NumberInvalid do
      PlIbanFormatter.new('123')
    end
    assert_raise PlIbanFormatter::NumberInvalid do
      PlIbanFormatter.new('123456789012345678901234567')
    end
  end

  test "getting formatted number" do
    f = PlIbanFormatter.new('12345678901234567890123456')
    assert_equal '12 3456 7890 1234 5678 9012 3456', f.get
    f = PlIbanFormatter.new('1234567890123456789012345678')
    assert_equal '1234 5678 9012 3456 7890 1234 5678', f.get
  end
end
