require 'rubygems'
require 'bundler'

require File.expand_path('../lib/jenkins-client/version', __FILE__)

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = "jenkins-client"
  gem.homepage = "http://github.com/john-griffin/jenkins-client"
  gem.license = "MIT"
  gem.summary = "Jenkins CI Ruby client."
  gem.description = "Manage a Jenkins CI server."
  gem.email = "johnog@gmail.com"
  gem.version = Jenkins::Client::VERSION
  gem.authors = [ "John Griffin" ]
  gem.files = Dir.glob('lib/**/*')
end

Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = Jenkins::Client::VERSION
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "jenkins-client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('LICENSE*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

