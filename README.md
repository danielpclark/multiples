# Multiples

Creates enumerators that step through integers from a union of two multiples.
A pattern from the two numbers is determined (much like two frequencies create
a pattern) and the resulting palindrome is given to a custom Enumerator for you
to use.

I've created this gem from a delightful discovery I made.  When going through all
the numbers that are multiples of two different digits a pattern comes through.
This pattern is a palindrome.  See for yourself:

```
For multiples of 3 with 5 we have.

3 5 6 9 10 12 15 18 20 21 24 25 27 30 33 35 36 39 40 42 45
3 2 1 3 1  2  3  3  2  1  3  1  2  3  3  2  1  3  1  2  3
```

The palindrome for the above differences example is `3,2,1,3,1,2,3`.  I thought this
may be true for other numbers as well so lets look at 4 with 5.

```
4 5 8 10 12 15 16 20 24 25 28 30 32 35 36 40
4 1 3 2  2  3  1  4  4  1  3  2  2  3  1  4
```

As you can see from this example another palindrome has arisen `4,1,3,2,2,3,1,4`. Upon
further study of these patterns I have also found that the palindrome will always be the
same length as the two numbers added together minus one.  So 3 and 5's palindrome is the
length `3+5-1=7` and 4 and 5's palindromes length is `4+5-1=8`.  I wrote code that tests
any two different digits and those are accurate lengths.

So if you'd like an iterator that steps through multiples without calculating every step
of the way you may use this gem for that.

### NOTES

* If one of the numbers is divisible by the other than this rule doesn't apply.
* The gem doesn't take into account zero and negative numbers.  If you wanted to you may progress backwards through negative numbers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multiples'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multiples

## Usage

```ruby
x = Multiples.new(3,5)
x.next
# => 3

x.each do |val|
  break val if val > 14
end
# => 15

x.lazy.select {|v| v % 10 == 0}.take(2).to_a
# => [20, 30]
x.next
# => 33 
x.phase
# => 1
x.prev
# => 30
x.phase
# => 0

y = Multiples.new(3,5)

y.lazy.take(4).to_a
# => [3, 5, 6, 9] 
y.next
# => 10 
y.prev
# => 9 

y.lazy.select {|v| v % 7 == 0 }.take(14).to_a
# => [21, 35, 42, 63, 70, 84, 105, 126, 140, 147, 168, 175, 189, 210]
```

## Benchmark

If you reuse the Enumerator (rather than re-initialzing it) you will gain a
performance advantage of about 100% (2x original).  If you create a new Enumerator each time
you use it your performance will be 30% worse than if you had not used this gem.
See the benchmark file in test/benches for an example and run `rake bench` to see
the results for yourself.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danielpclark/multiples.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

