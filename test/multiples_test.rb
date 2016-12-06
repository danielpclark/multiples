require 'test_helper'

class MultiplesTest < Minitest::Test
  def test_builds_proper_three_five_palindrome
    assert_equal [3,2,1,3,1,2,3], Multiples.new(3,5).palindrome
  end

  def test_builds_proper_four_five_palindrome
    assert_equal [4,1,3,2,2,3,1,4], Multiples.new(4,5).palindrome
  end
 
  def test_theory_of_any_two_numbers
    begin
      a = rand(20)
      b = rand(20)
    end until a != b
    x = Multiples.new(a,b).palindrome
    assert_equal x, x.reverse
  end

  def test_enum_and_lazy
    y = Multiples.new(3,5)
    x = y.lazy
    assert_equal [3,5,6,9,10,12], x.first(6)
    assert_equal 15, x.next
    assert_equal 15, y.current
    assert_equal 0, y.phase
    assert_equal 18, y.next
    assert_equal 1, y.phase
    assert_equal 20, y.next
    assert_equal 2, y.phase
    assert_equal 18, y.prev
    assert_equal 1, y.phase
    assert_equal 15, y.prev
    assert_equal 0, y.phase
    assert_equal 12, y.prev
    assert_equal 6, y.phase
    assert_equal 10, y.prev
    assert_equal 5, y.phase
    assert_equal [12,15,18,20], x.take(4).to_a
  end
  
  def test_enum_and_each
    x = Multiples.new(3,5)
    x.each do |val|
      break val if val == 21
    end
    assert_equal 24, x.next
  end

  def test_reset
    x = Multiples.new(3,5)
    assert_equal [3,5,6,9,10,12], x.lazy.first(6)
    x.reset!
    assert_equal [3,5,6,9,10,12], x.lazy.first(6)
    refute_equal [3,5,6,9,10,12], x.lazy.first(6)
  end

  def test_for_no_zeros
    x = Multiples.new(6,14).palindrome
    refute x.detect(&:zero?)
  end
end
