require './spec/spec_helper'
require './app/models/dummy'

RSpec.describe Dummy, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  it "creates a client" do
    expect(Dummy.client_1).to be_instance_of(Client)
    expect(Dummy.client_2).to be_instance_of(Client)
    expect(Dummy.client_3).to be_instance_of(Client)
    expect(Client.all.count).to eq(3)
  end

  it "creates an ip address" do
    expect(Dummy.ip_address_1).to be_instance_of(IpAddress)
    expect(Dummy.ip_address_2).to be_instance_of(IpAddress)
    expect(Dummy.ip_address_3).to be_instance_of(IpAddress)
    expect(IpAddress.all.count).to eq(3)
  end

  it "creates a payload request" do
    expect(Dummy.payload_request_1).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_2).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_3).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_4).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_5).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_6).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_7).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_8).to be_instance_of(PayloadRequest)
    expect(Dummy.payload_request_9).to be_instance_of(PayloadRequest)
    expect(PayloadRequest.all.count).to eq(9)
  end

  it "creates a custom payload request" do
    custom = Dummy.payload_request_custom(1, 1, 1, 1, 1, 1, 1, 10)
    expect(custom).to be_instance_of(PayloadRequest)
    expect(PayloadRequest.all.count).to eq(1)
  end

  it "creates a request type" do
    expect(Dummy.request_type_1).to be_instance_of(RequestType)
    expect(Dummy.request_type_2).to be_instance_of(RequestType)
    expect(Dummy.request_type_3).to be_instance_of(RequestType)
    expect(RequestType.all.count).to eq(3)
  end

  it "creates a screen resolution" do
    expect(Dummy.screen_resolution_1).to be_instance_of(ScreenResolution)
    expect(Dummy.screen_resolution_2).to be_instance_of(ScreenResolution)
    expect(Dummy.screen_resolution_3).to be_instance_of(ScreenResolution)
    expect(ScreenResolution.all.count).to eq(3)
  end

  it "creates a source" do
    expect(Dummy.source_1).to be_instance_of(Source)
    expect(Dummy.source_2).to be_instance_of(Source)
    expect(Dummy.source_3).to be_instance_of(Source)
    expect(Dummy.source_4).to be_instance_of(Source)
    expect(Source.all.count).to eq(4)
  end

  it "creates a u agent" do
    expect(Dummy.u_agent_1).to be_instance_of(UAgent)
    expect(Dummy.u_agent_2).to be_instance_of(UAgent)
    expect(Dummy.u_agent_3).to be_instance_of(UAgent)
    expect(Dummy.u_agent_4).to be_instance_of(UAgent)
    expect(UAgent.all.count).to eq(4)
  end

  it "creates a url" do
    expect(Dummy.url_1).to be_instance_of(Url)
    expect(Dummy.url_2).to be_instance_of(Url)
    expect(Dummy.url_3).to be_instance_of(Url)
    expect(Dummy.url_4).to be_instance_of(Url)
    expect(Dummy.url_5).to be_instance_of(Url)
    expect(Dummy.url_6).to be_instance_of(Url)
    expect(Dummy.url_7).to be_instance_of(Url)
    expect(Dummy.url_8).to be_instance_of(Url)
    expect(Dummy.url_9).to be_instance_of(Url)
    expect(Url.all.count).to eq(9)
  end
end
