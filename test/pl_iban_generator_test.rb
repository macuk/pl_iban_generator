require 'test_helper'

class PLIbanGeneratorTest < ActiveSupport::TestCase
  test "changing parameters to strings" do
    g = PlIbanGenerator.new(12345678, 1234567890123456, 3)
    assert_equal '12345678', g.bank_code
    assert_equal '1234567890123456', g.account_no
    assert_equal '3', g.prefix
  end

  test "cleaning parameters" do
    g = PlIbanGenerator.new('1234 5678', '0000 1111 2222 3333')
    assert_equal '12345678', g.bank_code
    assert_equal '0000111122223333', g.account_no
  end

  test "check digits calculation" do
    g = PlIbanGenerator.new(11402004, '0000 3002 3471 3036', '')
    assert_equal '47114020040000300234713036', g.get
    g.account_no = '0000 3302 0772 6785'
    assert_equal '43114020040000330207726785', g.get
  end

  test "to_s implementation" do
    g = PlIbanGenerator.new('1140 2004', '0000 3002 3471 3036', '')
    assert_equal '47 1140 2004 0000 3002 3471 3036', g.to_s
    g.prefix = 'PL'
    assert_equal 'PL47 1140 2004 0000 3002 3471 3036', g.to_s
  end

  test "check number size exception" do
    assert_raise PlIbanGenerator::NumberInvalid do
      g = PlIbanGenerator.new(nil, nil)
    end
    assert_raise PlIbanGenerator::NumberInvalid do
      g = PlIbanGenerator.new('1140 2004 4', '0000 3002 3471 3036', '')
    end
    assert_raise PlIbanGenerator::NumberInvalid do
      g = PlIbanGenerator.new('1140 200', '0000 3002 3471 3036', '')
    end
    assert_raise PlIbanGenerator::NumberInvalid do
      g = PlIbanGenerator.new('1140 2004', '0000 3002 3471 3036 9', '')
    end
    assert_raise PlIbanGenerator::NumberInvalid do
      g = PlIbanGenerator.new('1140 2004', '0000 3002 3471 303', '')
    end
  end
end
