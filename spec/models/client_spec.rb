require './spec/spec_helper'
require './app/models/client'

RSpec.describe Client, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  let(:client) { Dummy.client_1 }

  it "takes a client and returns a client object" do
    client = Dummy.client_1
    expect(client).to be_an_instance_of Client
  end

  it "has an identifier" do
    expect(client.identifier).to eq("jumpstartlab")
  end

  it "has a root url" do
    expect(client.root_url).to eq("www.jumpstartlab.com")
  end

  it "will not create a client without an identifier" do
    bad_client = Client.new("identifier" => "", "root_url" => "www.jlab.com")
    expect(bad_client).to be_invalid
  end

  it "will not create a client without a root url" do
    bad_client = Client.new("identifier" => "jumpstartlab", "root_url" => "")
    expect(bad_client).to be_invalid
  end

  it "will not allow duplicate identifier" do
    Dummy.client_1
    bad_client = Client.new("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab2.com")
    expect(bad_client).to be_invalid
  end

  it "will not allow duplicate root urls" do
    Dummy.client_1
    bad_client = Client.new("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")
    expect(bad_client).to be_invalid
  end

  # skip "will get all request types associated with a client" do
  #
  #   client = Client.create("identifier" => "jumpstartlab",
  #     "root_url" => "www.jumpstartlab.com")
  #
  #     PayloadRequest.create(
  #       "url_id"=>1,
  #       "requested_at"=>"2013-02-16 21:38:28 -0700",
  #       "responded_in"=>37,
  #       "source_id"=>2,
  #       "request_type_id"=>1,
  #       "u_agent_id"=>5,
  #       "screen_resolution_id"=>4,
  #       "ip_address_id"=>6,
  #       "client_id"=>1)
  #
  #       RequestType.create("verb" =>"GET")
  #
  #       binding.pry
  #   thingy = client.payload_requests.request_type
  #   expect(thingy).to be("Hello World!")
  # end

end
