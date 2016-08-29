require './spec/spec_helper'
require './app/models/payload_request'

RSpec.describe PayloadRequest, type: :model do
  after :each do
      DatabaseCleaner.clean
    end

  let(:payload) { Dummy.payload_request_1 }

  it "takes a payload and returns a payload request object" do
    expect(payload).to be_an_instance_of PayloadRequest
  end

  it "has a url id" do
    expect(payload.url_id).to eq(1)
  end

  it "has a date" do
    time = Time.new
    expect(payload.requested_at).to be_between(time - 10, time + 10).inclusive
  end

  it "has a responded in" do
    expect(payload.responded_in).to be_between(0, 40).inclusive
  end

  it "has a source_id" do
    expect(payload.source_id).to eq(1)
  end

  it "has a request type_id" do
    expect(payload.request_type_id).to eq(1)
  end

  it "has a u_agent_id" do
    expect(payload.u_agent_id).to eq(1)
  end

  it "has a screen_resolution_id width" do
    expect(payload.screen_resolution_id).to eq(1)
  end

  it "has an ip_address_id address" do
    expect(payload.ip_address_id).to eq(1)
  end

  it "has an client_id address" do
    expect(payload.client_id).to eq(1)
  end

  it "will not create a payload request without a url id" do
    expect(PayloadRequest.new(:url_id => "")).to be_invalid
  end

  it "will not create a payload request without a requested_at" do
    expect(PayloadRequest.new(:requested_at => "")).to be_invalid
  end

  it "will not create a payload request without a responded_in" do
    expect(PayloadRequest.new(:responded_in => "")).to be_invalid
  end

  it "will not create a payload request without a source_id" do
    expect(PayloadRequest.new(:source_id => "")).to be_invalid
  end

  it "will not create a payload request without a request_type_id" do
    expect(PayloadRequest.new(:request_type_id => "")).to be_invalid
  end

  it "will not create a payload request without a u_agent_id" do
    expect(PayloadRequest.new(:u_agent_id => "")).to be_invalid
  end

  it "will not create a payload request without a screen_resolution_id" do
    expect(PayloadRequest.new(:screen_resolution_id => "")).to be_invalid
  end

  it "will not create a payload request without an ip_address_id" do
    expect(PayloadRequest.new(:ip_address_id => "")).to be_invalid
  end

  it "will not create a payload request without a client_id" do
    expect(PayloadRequest.new(:client_id => "")).to be_invalid
  end

  def payload_w_response_time(time)
    {"url_id"=>1,
    "requested_at"=>"2013-02-16 21:38:28 -0700",
    "responded_in"=>time,
    "source_id"=>2,
    "request_type_id"=>3,
    "u_agent_id"=>5,
    "screen_resolution_id"=>4,
    "ip_address_id"=>6,
    "client_id"=>10}
  end

  it "will find the average response time" do
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3

    expect(PayloadRequest.all.length).to eq(3)
    expect(PayloadRequest.average_response_time).to eq(20)
  end

  it "will find the max response time" do
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3

    expect(PayloadRequest.all.length).to eq(3)
    expect(PayloadRequest.max_response_time).to eq(30)
  end

  it "will find the min response time" do
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3

    expect(PayloadRequest.all.length).to eq(3)
    expect(PayloadRequest.min_response_time).to eq(10)
  end

end
