def jenkins_config(url)
  @client = Jenkins::Client.new
  @client.configure do |c|
    c.username = "testuser"
    c.password = "testpass"
    c.url = url
  end
end

def empty_jenkins_config
  jenkins_config("https://emptyjenkinstest.com")
end

