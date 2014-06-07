# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/lgtm/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-lgtm"
  spec.version       = Ruboty::Lgtm::VERSION
  spec.authors       = ["negipo"]
  spec.email         = ["negipo@gmail.com"]
  spec.summary       = %q{An ruboty handler to generate lgtm image.}
  spec.homepage      = "http://github.com/negipo/ruboty-lgtm"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "ruboty"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
