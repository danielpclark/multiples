require "multiples/version"
require "multiples/multiples_enumerator"

module Multiples
  def Multiples.new(*args)
    MultiplesEnumGenerator.new(*args)
  end
end
