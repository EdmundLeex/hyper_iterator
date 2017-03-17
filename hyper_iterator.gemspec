# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hyper_iterator/version'

Gem::Specification.new do |spec|
  spec.name          = "hyper_iterator"
  spec.version       = HyperIterator::VERSION
  spec.summary       = "Implementation of Ruby Iterators with High Performance"
  spec.description   = ""

  spec.required_ruby_version = ">= 2.1.2"

  spec.license = "MIT"

  spec.authors  = ["Edmund Li"]
  spec.email    = ["edmund.xz.lee@gmail.com"]
  spec.homepage = "https://github.com/EdmundLeex/hyper_iterator"

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
