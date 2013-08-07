# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_monitor/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_monitor"
  spec.version       = RailsMonitor::VERSION
  spec.authors       = ["Kevin Radloff"]
  spec.email         = ["radsaq@gmail.com"]
  spec.description   = %q{Easily monitor your rails application}
  spec.summary       = %q{Easily monitor your rails application from a convenient web page, or define endpoints for 3rd party software like nagios.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'actionpack', '>= 3.1.0'
  spec.add_dependency 'jquery-rails'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rack'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
end
