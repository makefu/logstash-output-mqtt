Gem::Specification.new do |s|
  s.name = 'logstash-output-mqtt'
  s.version         = "1.3.0"
  s.licenses = ["Apache-2.0"]
  s.summary = "This is Logstash output plugin for the http://mqtt.org/[MQTT] protocol"
  s.description = "This gem is a logstash plugin required to be installed on top of the Logstash core pipeline using $LS_HOME/bin/plugin install gemname. This gem is not a stand-alone program"
  s.authors = ["Tommi Palomäki","Felix Richter"]
  s.email = "tommi.palomaki@digia.com"
  s.homepage = "https://github.com/makefu/logstash-output-mqtt"
  s.require_paths = ["lib"]

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
  
  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", ">= 1.60", "<= 2.99"
  s.add_runtime_dependency "logstash-codec-json"
  s.add_runtime_dependency 'mqtt', '~> 0.6', '>= 0.6.0'

  s.add_development_dependency "logstash-devutils"
end
