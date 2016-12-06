require 'benchmark/ips'
require 'multiples'

premade = Multiples.new(3,5)
premade2 = Multiples.new(7,11)

Benchmark.ips do |x|
  x.report("Traditional") do
    (1..Float::INFINITY).lazy.select {|v| (v % 3 == 0 || v % 5 == 0) && v % 7 == 0 }.take(14).to_a
  end

  x.report("Multiples") do
    premade.lazy.select {|v| v % 7}.take(14).to_a
  end

  x.report("new()-and-Multiples") do
    Multiples.new(3,5).lazy.select {|v| v % 7}.take(14).to_a
  end

  x.report("Traditional2") do
    (1..Float::INFINITY).lazy.select {|v| (v % 7 == 0 || v % 11 == 0) && v % 13 == 0 }.take(14).to_a
  end

  x.report("Multiples2") do
    premade2.lazy.select {|v| v % 13}.take(14).to_a
  end

  x.report("new()-and-Multiples2") do
    Multiples.new(7,11).lazy.select {|v| v % 13}.take(14).to_a
  end
end
