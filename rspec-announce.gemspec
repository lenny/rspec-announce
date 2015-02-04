# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rspec/announce/version'

Gem::Specification.new do |spec|
  spec.name          = 'rspec-announce'
  spec.version       = Rspec::Announce::VERSION
  spec.authors       = ['Lenny Marks']
  spec.email         = ['lenny@aps.org']
  spec.summary       = %q{Adds the \#announce(msg) to facilitate Cucumber style output without Cucumber (and separate step definitions)}
  spec.description   = %q{Block comments with runtime output support.}
  spec.homepage      = 'https://github.com/lenny/rspec-announce'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rspec', '>= 2.99'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
