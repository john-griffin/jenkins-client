# Jenkins::Client [![travis](https://secure.travis-ci.org/john-griffin/jenkins-client.png)](http://travis-ci.org/john-griffin/jenkins-client) [![Dependency Status](https://gemnasium.com/john-griffin/jenkins-client.png)](https://gemnasium.com/john-griffin/jenkins-client)

This is a small gem used for listing, finding and creating Jenkins jobs on a Jenkins CI server.

## Installation

Add this line to your application's Gemfile:

    gem 'jenkins-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jenkins-client

## Usage

In rails add an initialiser like this

``` ruby
Jenkins::Client.configure do |c|
  c.username = "user"
  c.password = "pass"
  c.url = "http://jenkinsurl.com"
end
```

Then you can issue the following commands in your app.

### All

`Jenkins::Client::Job.all` pulls back a list of objects that represent all the Jenkins jobs on the server.

### Find

`Jenkins::Client::Job.find("job_name")` pulls back a single Jenkins job based on the job name.

### Create

`Jenkins::Client::Job.create("job_name", config).should be_true` will create a new Jenkins job on the server based on the config you pass in. Jenkins uses XML config files on the server and this is what you should send as the config. Example

``` xml
<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties/>
  <scm class="hudson.scm.NullSCM"/>
  <canRoam>true</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers class="vector"/>
  <concurrentBuild>false</concurrentBuild>
  <builders/>
  <publishers/>
  <buildWrappers/>
</project>
```

To export an existing config simply look in the jobs path inside your Jenkins server and pull back a job's `config.xml` file.

### Start

`Jenkins::Client::Job.start("job_name")` will start a build for the job which name is passed by parameter

### LastBuild

`Jenkins::Client::Job.lastBuild("job_name")` will give full informations about the last build of the job which name is passed by parameter

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
