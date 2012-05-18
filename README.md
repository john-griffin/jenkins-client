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
client = Jenkins::Client.new
client.username = "user"
client.password = "pass"
client.url = "http://jenkinsurl.com"
```

Then you can issue the following commands in your app.

### Jobs

Retrieve a hash of jobs with the job name as key.

``` ruby
client.jobs
```

#### Create

Create a new Jenkins job on the server with a given configuration.

``` ruby
job = Jenkins::Client::Job.new({ :name => "job_name" })
job.create!(config)
```

Jenkins uses XML config files on the server and this is what you should send as the config.

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

#### Start

Starts a job.

``` ruby
job = Jenkins::Client::Job.new({ :name => "job_name" })
job.start!
```

#### Delete

Delete a Jenkins job on the server.

``` ruby
job = Jenkins::Client::Job.new({ :name => "job_name" })
job.delete!
```

#### Last Build

Retrieve the last build.

``` ruby
job.last_build # last build
job.last_successful_build # last successful build
job.last_failed_build # last failed build
```

### Build

Retrieve the console text of a build.

``` ruby
job.last_failed_build.console_text
```

## Changelog/History

Can be found [here](https://github.com/john-griffin/jenkins-client/blob/master/CHANGELOG.md).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
