require 'minitest_helper'

class TestHashExtension < MiniTest::Test

  def test_similarity_in_same_size_hashes
    h = {one: 1, two: 2, three: 3, four: 4, five: 5, 
         six: 6, seven: 7, eight: 8, nine: 9, ten: 10}

    assert_equal 1, h.similarity_to(h)
    assert_equal 0.9, h.similarity_to(h.merge(one: 0))
    assert_equal 0.8, h.similarity_to(h.merge(one: 0, two: 0))
    assert_equal 0.7, h.similarity_to(h.merge(one: 0, two: 0, three: 0))
    assert_equal 0.6, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0))
    assert_equal 0.5, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0, five: 0))
    assert_equal 0.4, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0, five: 0,
                                              six: 0))
    assert_equal 0.3, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0, five: 0,
                                              six: 0, seven: 0))
    assert_equal 0.2, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0, five: 0,
                                              six: 0, seven: 0, eight: 0))
    assert_equal 0.1, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0, five: 0,
                                              six: 0, seven: 0, eight: 0, nine: 0))
    assert_equal 0.0, h.similarity_to(h.merge(one: 0, two: 0, three: 0, four: 0, five: 0,
                                              six: 0, seven: 0, eight: 0, nine: 0, ten: 0))
  end

  def test_similarity_in_different_size_hashes
    h = {one: 1, two: 2, three: 3, four: 4} 

    assert_in_delta 0.733, h.similarity_to({one: 1, two: 2, three: 3, four: 4, five: 5})
    assert_equal 0.675, h.similarity_to({one: 1, two: 2, three: 3})
    assert_in_delta 0.416, h.similarity_to({one: 1, two: 2})
    assert_in_delta 0.208, h.similarity_to({one: 0, two: 2})
    assert_in_delta 0.183, h.similarity_to({one: 0, two: 0, three: 0, four: 4, five: 5})
    assert_equal 0.0, h.similarity_to({one: 0, two: 0, three: 0, four: 0, five: 5})
  end

  def test_same_size_has_better_similarity_than_different_size
    h = {one: 1, two: 2, three: 3, four: 4} 

    assert h.similarity_to({one: 1, two: 2, three: 3}) <
            h.similarity_to(one: 1, two: 2, three: 3, four: 0)
  end

  def test_symmetry_of_similarity_operation
    h = {one: 1, two: 2, three: 3, four: 4}
    o = {one: 2, two: 1, three: 3, four: 5}

    assert_equal h.similarity_to(o), o.similarity_to(h)

    h = {one: 1, two: 2, three: 3, four: 4}
    o = {one: 1, two: 2, three: 3, four: 4, five: 5}

    assert_equal h.similarity_to(o), o.similarity_to(h)
  end
end
