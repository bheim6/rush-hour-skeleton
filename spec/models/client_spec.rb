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

  it "knows its average response time" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3

    expect(client.average_response_time).to eq(20)
  end

  it "knows its max response time" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3

    expect(client.max_response_time).to eq(30)
  end

  it "knows its min response time" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3

    expect(client.min_response_time).to eq(10)
  end

  it "knows its most frequent request type" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    pr = Dummy.payload_request_custom(1, 1, 1, 1, 1, 1, 1, 10)
    Dummy.request_type_1
    Dummy.request_type_2
    Dummy.request_type_3

    expected_request_type = RequestType.find_by("id" => pr.request_type_id)
    expect(client.most_frequesnt_request_type).to eq(expected_request_type)
  end

  it "will list all of its http verbs" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    pr = Dummy.payload_request_custom(1, 1, 1, 1, 1, 1, 1, 10)
    Dummy.request_type_1
    Dummy.request_type_2
    Dummy.request_type_3

    expect(client.list_verbs).to include("GET", "POST", "DELETE")
  end

  it "will give breakdown of web_browsers across all requests" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    pr = Dummy.payload_request_custom(1, 1, 1, 1, 1, 1, 1, 10)
    Dummy.u_agent_1
    Dummy.u_agent_2
    Dummy.u_agent_3

    expect(client.browser_breakdown).to include("Chrome" => 3, "Firefox" => 1)
  end

  it "will give breakdown of web_browsers across all requests" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    pr = Dummy.payload_request_custom(1, 1, 1, 1, 1, 1, 1, 10)
    Dummy.u_agent_1
    Dummy.u_agent_2
    Dummy.u_agent_3

    expect(client.os_breakdown).to include("Windows Vista" => 2,
                                           "MAC OSX" => 1,
                                           "Linux" => 1)
  end

  it "knows resolutions across all requests" do
    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    pr = Dummy.payload_request_custom(1, 1, 1, 1, 1, 1, 1, 10)
    Dummy.screen_resolution_1
    Dummy.screen_resolution_2
    Dummy.screen_resolution_3

    expect(client.display_resolutions).to include(["1920", "1280"],
                                                  ["640", "480"],
                                                  ["800", "600"])
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
