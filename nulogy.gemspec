# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nulogy/version'

Gem::Specification.new do |spec|
  spec.name          = 'nulogy'
  spec.version       = Nulogy::VERSION
  spec.authors       = ['Jamie Hale']
  spec.email         = ['jamie@smallarmyofnerds.com']

  spec.summary       = 'Nulogy code challenge'
  spec.description   = 'Library to calculate product markups'
  spec.homepage      = 'https://github.com/jamiehale/nulogy'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'ZenTest'
  spec.add_development_dependency 'rspec-autotest'
end
