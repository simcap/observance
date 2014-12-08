require 'minitest_helper'

class TestObservance < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Observance::VERSION
  end

  def test_it_does_something_useful
    assert false
  end
end
