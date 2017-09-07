# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "elemac/version"

Gem::Specification.new do |spec|
  spec.authors       = ["Michał Prostko"]
  spec.license       = "MIT"
  spec.summary       = 'Ruby binding for ELEMAC SA-03 aquarium controller'
  spec.description   = 'Ruby binding for ELEMAC SA-03 aquarium controller'
  spec.homepage      = "https://github.com/mprostko/elemac"

  spec.name          = 'elemac'
  spec.version       = Elemac::VERSION
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = []
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0"

  spec.add_dependency             "hidapi", "~> 0.1.9"
  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
