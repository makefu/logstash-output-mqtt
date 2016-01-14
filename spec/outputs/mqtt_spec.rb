# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/outputs/mqtt"
require "logstash/codecs/json"
require "logstash/event"

describe LogStash::Outputs::MQTT do
  # Define a sample event and its JSON encoded form
  let(:sample_event) { LogStash::Event.new("message" => "test message", "@timestamp" => "2016-01-01") }
  encoded_event = "{\"message\":\"test message\",\"@timestamp\":\"2016-01-01T00:00:00.000Z\",\"@version\":\"1\"}"

  settings = {
    "host" => "test.mosquitto.org",
    "topic" => "hello"
  }
  let(:output) { LogStash::Outputs::MQTT.new(settings) }
  let(:stub_client) { Object.new }

  before do
    output.register
  end

  describe "receive message" do

    it "connects and publishes with correct arguments" do

      expect(MQTT::Client).to receive(:connect).with(
        :host => "test.mosquitto.org",
        :port => 8883
      ) do |*args, &block|
        block.call(stub_client)
      end

      expect(stub_client).to receive(:publish).with("hello", encoded_event, false, 0)

      output.receive(sample_event)
    end
  end

  describe "multi_receive" do
    it "connects once and publishes all messages" do

      expect(MQTT::Client).to receive(:connect).once.with(
        :host => "test.mosquitto.org",
        :port => 8883
      ) do |*args, &block|
        block.call(stub_client)
      end

      expect(stub_client).to receive(:publish).exactly(3).times.with("hello", encoded_event, false, 0)

      three_events = [sample_event, sample_event, sample_event]
      output.multi_receive(three_events)
    end
  end
end