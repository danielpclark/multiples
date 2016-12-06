# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multiples/version'

Gem::Specification.new do |spec|
  spec.name          = "multiples"
  spec.version       = Multiples::VERSION
  spec.authors       = ["Daniel P. Clark"]
  spec.email         = ["6ftdan@gmail.com"]
  spec.summary       = %q{Creates enumerators that step through integers from a union of two multiples"}
  spec.description   = %q{Creates enumerators that step through integers from a union of two multiples. A pattern from the two numbers is determined (much like two frequencies create a pattern) and the resulting palindrome is given to a custom Enumerator for you to use."}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
