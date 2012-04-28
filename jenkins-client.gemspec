# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "jenkins-client"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Griffin"]
  s.date = "2012-04-28"
  s.description = "Manage a Jenkins CI server."
  s.email = "johnog@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    "lib/jenkins-client.rb",
    "lib/jenkins-client/build.rb",
    "lib/jenkins-client/client.rb",
    "lib/jenkins-client/job.rb",
    "lib/jenkins-client/version.rb"
  ]
  s.homepage = "http://github.com/john-griffin/jenkins-client"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Jenkins CI Ruby client."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>, ["~> 0.7.6"])
      s.add_runtime_dependency(%q<faraday_middleware>, ["~> 0.8.4"])
      s.add_runtime_dependency(%q<rash>, ["~> 0.3.2"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rake>, ["~> 0.9"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6"])
      s.add_development_dependency(%q<yard>, ["~> 0.6"])
      s.add_development_dependency(%q<webmock>, ["~> 1.8.2"])
    else
      s.add_dependency(%q<faraday>, ["~> 0.7.6"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.8.4"])
      s.add_dependency(%q<rash>, ["~> 0.3.2"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rake>, ["~> 0.9"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6"])
      s.add_dependency(%q<yard>, ["~> 0.6"])
      s.add_dependency(%q<webmock>, ["~> 1.8.2"])
    end
  else
    s.add_dependency(%q<faraday>, ["~> 0.7.6"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.8.4"])
    s.add_dependency(%q<rash>, ["~> 0.3.2"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rake>, ["~> 0.9"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6"])
    s.add_dependency(%q<yard>, ["~> 0.6"])
    s.add_dependency(%q<webmock>, ["~> 1.8.2"])
  end
end

