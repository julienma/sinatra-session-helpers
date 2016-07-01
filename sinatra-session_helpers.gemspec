# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/session_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-session_helpers"
  spec.version       = Sinatra::SessionHelpers::VERSION
  spec.authors       = ["Julien Ma"]
  spec.email         = ["julienma@users.noreply.github.com"]

  spec.summary       = %q{Helper methods for Sinatra's :sessions management.}
  spec.homepage      = "https://github.com/julienma/sinatra-session_helpers"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra", "~> 1.4.0"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
