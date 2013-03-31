# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/browserify/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-browserify"
  spec.version       = "0.0.1"
  spec.authors       = ["Colby Rabideau"]
  spec.email         = ["crabideau5691@gmail.com"]
  spec.description   = "Guard plugin for Browserify"
  spec.summary       = "Guard plugin that automagically runs browserify when a file is changed"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.require_path  = "lib"

  spec.add_dependency "guard"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
