# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'passworks/version'

Gem::Specification.new do |spec|
  spec.name          = "passworks"
  spec.version       = Passworks::VERSION
  spec.authors       = ["Luis Mendes", "Miguel Verissimo", "Tiago Parreira"]
  spec.email         = ["luis@passworks.io", "miguel@passworks.io", "tiago@passworks.io"]
  spec.summary       = %q{Passworks API client}
  spec.description   = %q{Provides a simple interface to Passworks API}
  spec.homepage      = "https://passworks.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency 'faraday_middleware', '>= 0.9.1', '< 0.14.0'

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "minitest-vcr"
end
