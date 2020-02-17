require 'test_helper'

class DeclinationServiceTest < ActiveSupport::TestCase
  setup do
    @person = people(:one)
    @hash = DeclinationService.run(@person)
  end

  test "should be array of hashs" do
    assert_equal 5, @hash.count
  end

  test "verification of file validity by reference" do
    assert_equal @hash[0][:full_name], "Александрова Александра Алексантровича"
    assert_equal @hash[1][:full_name], "Александрову Александру Алексантровичу"
    assert_equal @hash[2][:full_name], "Александровым Александром Алексантровичем"
    assert_equal @hash[3][:full_name], "Александрова Александра Алексантровича"
    assert_equal @hash[4][:full_name], "Александрове Александре Алексантровиче"
  end
end
