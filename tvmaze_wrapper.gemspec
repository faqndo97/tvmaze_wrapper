# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tvmaze_wrapper/version'

Gem::Specification.new do |spec|
  spec.name          = 'tvmaze_wrapper'
  spec.version       = SuperDispatch::VERSION
  spec.authors       = 'Facundo'
  spec.email         = 'facuespinosa97@gmail.com'
  spec.summary       = 'Ruby wrapper for TvMaze API.'
  spec.description   = 'Ruby wrapper for TvMaze API.'
  spec.homepage      = ''
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = %w[lib]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock'

  spec.add_dependency 'rest-client'
end
