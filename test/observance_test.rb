require 'minitest_helper'

class TestObservance < MiniTest::Test
  def test_returns_ordered_observation_from_same_size_hashes
    o1 = {one: 1, two: 2, three: 3, four: 4}
    o2 = {one: 1, two: 2, three: 3, four: 4}
    o3 = {one: 1, two: 2, three: 3, four: 0}
    o4 = {one: 1, two: 2, three: 0, four: 4}
    o5 = {one: 1, two: 2, three: 0, four: 0}
    o6 = {one: 1, two: 0, three: 0, four: 0}
    o7 = {one: 0, two: 0, three: 0, four: 0}

    observations = Observance.run(o1, o2, o3, o4, o5, o6, o7)

    assert_equal o5, observations[0].object 
    assert_equal o3, observations[1].object 
    assert_equal o4, observations[2].object 
    assert_equal o1, observations[3].object 
    assert_equal o2, observations[4].object 
    assert_equal o6, observations[5].object 
    assert_equal o7, observations[6].object 

    assert_equal 0.6786, observations[0].rating 
    assert_equal 0.6429, observations[1].rating 
    assert_equal 0.6429, observations[2].rating 
    assert_equal 0.6071, observations[3].rating 
    assert_equal 0.6071, observations[4].rating 
    assert_equal 0.5714, observations[5].rating 
    assert_equal 0.3929, observations[6].rating 
  end

  def test_returns_ordered_observation_from_different_size_hashes
    o1 = {one: 1, two: 2, three: 3, four: 4, five: 5}
    o2 = {one: 1, two: 2, three: 3, four: 4}
    o3 = {zero: 0, one: 1, two: 2, three: 3, four: 0}
    o4 = {one: 1, two: 2, three: 0, four: 4}
    o5 = {one: 1, two: 2, three: 0, four: 0, ten: 10, eleven: 11}
    o6 = {one: 1, two: 0}
    o7 = {one: 0, two: 0, three: 0}

    observations = Observance.run(o1, o2, o3, o4, o5, o6, o7)

    assert_equal o4, observations[0].object 
    assert_equal o2, observations[1].object 
    assert_equal o1, observations[2].object 
    assert_equal o3, observations[3].object 
    assert_equal o5, observations[4].object 
    assert_equal o6, observations[5].object 
    assert_equal o7, observations[6].object 

    assert_equal 0.5054, observations[0].rating 
    assert_equal 0.5048, observations[1].rating 
    assert_equal 0.4793, observations[2].rating 
    assert_equal 0.4491, observations[3].rating 
    assert_equal 0.3965, observations[4].rating 
    assert_equal 0.3095, observations[5].rating 
  end

  def test_returns_ordered_observation_from_same_size_arrays
    o1 = [1, 2, 3, 4]
    o2 = [1, 2, 3, 4]
    o3 = [1, 2, 3, 0]
    o4 = [1, 2, 0, 4]
    o5 = [1, 2, 0, 0]
    o6 = [1, 0, 0, 0]
    o7 = [0, 0, 0, 0]

    observations = Observance.run(o1, o2, o3, o4, o5, o6, o7)

    assert_equal o5, observations[0].object 
    assert_equal o3, observations[1].object 
    assert_equal o4, observations[2].object 
    assert_equal o1, observations[3].object 
    assert_equal o2, observations[4].object 
    assert_equal o6, observations[5].object 
    assert_equal o7, observations[6].object 

    assert_equal 0.6786, observations[0].rating 
    assert_equal 0.6429, observations[1].rating 
    assert_equal 0.6429, observations[2].rating 
    assert_equal 0.6071, observations[3].rating 
    assert_equal 0.6071, observations[4].rating 
    assert_equal 0.5714, observations[5].rating 
  end
end
