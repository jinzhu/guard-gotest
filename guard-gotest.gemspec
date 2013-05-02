# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/gotest/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-gotest'
  spec.version       = Guard::GotestVersion::VERSION
  spec.authors       = ["Jon Doveston"]
  spec.email         = ["jon@doveston.me.uk"]
  spec.description   = %q{Guard gem for Go test}
  spec.summary       = %q{Automatically runs go test in the directories of changed files.}
  spec.homepage      = 'http://rubygems.org/gems/guard-gotest'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'guard', '>= 1.8'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
