# -*- encoding: utf-8 -*-
require File.expand_path('../lib/jenkins-client/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["John Griffin"]
  gem.email         = ["johnog@gmail.com"]
  gem.description   = "List, find and create Jenkins jobs on a Jenkins CI server"
  gem.summary       = "List, find and create Jenkins jobs on a Jenkins CI server"
  gem.homepage      = "https://github.com/john-griffin/jenkins-client"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "jenkins-client"
  gem.require_paths = ["lib"]
  gem.version       = Jenkins::Client::VERSION

  gem.add_dependency "faraday", "~> 0.7.6"
  gem.add_dependency "faraday_middleware", "~> 0.8.4"
  gem.add_dependency 'rash', "~> 0.3.2"

  gem.add_development_dependency "rspec", "~> 2.8.0"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "webmock", "~> 1.7.10"
  gem.add_development_dependency "guard-rspec", "~> 0.6.0"
end
