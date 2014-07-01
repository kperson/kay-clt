# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kay/version'

Gem::Specification.new do |spec|
  spec.name          = "kay"
  spec.version       = Kay::VERSION
  spec.authors       = ["Kelton Person"]
  spec.email         = ["kelton.person@gmail.com"]
  spec.summary       = 'Kay CLT client'
  spec.description   = 'A CLT client to control to kay cluster'
  spec.homepage      = "https://github.com/kperson/kay-clt"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["kay"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'rest-client', '~> 1.6.7'
  spec.add_runtime_dependency 'colorize'

end
