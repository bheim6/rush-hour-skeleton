require './spec/spec_helper'
require './app/models/u_agent'

RSpec.describe UAgent, type: :model do

  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end

  let(:u_agent) { UAgent.new("browser" =>"Chrome", "operating_system" => "Macintosh")}

  it "takes a u agent and returns a u agent object" do
    expect(u_agent).to be_an_instance_of UAgent
  end

  it "has a u agent browser" do
    expect(u_agent.browser).to eq("Chrome")
  end

  it "has a u agent operating_system" do
    expect(u_agent.operating_system).to eq("Macintosh")
  end

  it "will not create a u agent without a browser" do
    expect(UAgent.new("browser" => "")).to be_invalid
  end

  it "will not create a u agent without a operating_system" do
    expect(UAgent.new("operating_system" => "")).to be_invalid
  end

  it "will not allow duplicate browser" do
    UAgent.create("browser" =>"Chrome")
    expect(UAgent.new("browser" => "Chrome")).to be_invalid
  end

  it "will not allow duplicate operating_system" do
    UAgent.create("operating_system" =>"Macintosh")
    expect(UAgent.new("operating_system" => "Macintosh")).to be_invalid
  end

  def make_some_u_agents_and_payload_requests

      u_agent_pairs = [["Windows Vista", "Chrome"],
                       ["Linux", "Chrome"],
                       ["Mac OS", "Safari"]]
      u_agent_pairs.each do |u_a_pair|
        UAgent.create("operating_system" => u_a_pair[0],
                      "browser"          => u_a_pair[1])
      end

      [1,3,1,2,2,2].each do |u_agent_id|
        PayloadRequest.create(
          "url_id"                =>  1,
          "requested_at"          =>  "2013-02-16 21:38:28 -0700",
          "responded_in"          =>  35,
          "source_id"             =>  2,
          "request_type_id"       =>  1,
          "u_agent_id"            =>  u_agent_id,
          "screen_resolution_id"  =>  4,
          "ip_address_id"                 =>  6,
          "client_id"             =>  10)
      end
  end

  it "can break down by web browser and operating system" do
    make_some_u_agents_and_payload_requests

    expect(UAgent.breakdown("browser")).to eq({"Chrome"=>5,
                                               "Safari"=>1})
    expect(UAgent.breakdown("operating_system")).to eq({"Windows Vista"=>2,
                                                        "Linux"=>3,
                                                        "Mac OS"=>1})
  end

  skip "knows the web browser breakdown across all requests" do
    # make_some_u_agents_and_payload_requests
    # expect(UAgent.browser_breakdown).to eq({"Chrome"=>5, "Safari"=>1})
    # url_id, source_id, request_type_id, u_agent_id, screen_resolution_id, ip_address_id, client_id, response_time
    Dummy.payload_request_1 # 1, 1, 1, 1, 1, 1, 1, 10 u_agent_1 - "Windows Vista", "browser" =>"Chrome"
    Dummy.payload_request_2 # 2, 2, 2, 2, 2, 2, 1, 20 u_agent_2 - "MAC OSX", "browser" =>"Chrome"
    Dummy.payload_request_4 # 4, 1, 1, 1, 1, 1, 2, 10 u_agent_1 - "Windows Vista", "browser" =>"Chrome"
    Dummy.payload_request_5 # 5, 2, 2, 2, 2, 2, 2, 20 u_agent_2 - "MAC OSX", "browser" =>"Chrome"
    Dummy.payload_request_9 # 9, 3, 3, 3, 3, 3, 3, 25 u_agent_3 - "Linux", "browser" =>"Firefox"
    expect(PayloadRequest.all.count).to eq(5)

    Dummy.u_agent_1 # "operating_system" =>"Windows Vista", "browser" =>"Chrome"
    Dummy.u_agent_2 # "operating_system" =>"MAC OSX", "browser" =>"Chrome"
    Dummy.u_agent_3 # "operating_system" =>"Linux", "browser" =>"Firefox"
    expect(UAgent.all.count).to eq(3)
    expect(UAgent.u_agent_breakdown.values).to include(2,1)
    expect(UAgent.u_agent_breakdown.length).to eq(3)
    expect(UAgent.u_agent_breakdown.keys).to all(be_an_instance_of(UAgent))
  end

  it "knows the operating system across all requests" do
    make_some_u_agents_and_payload_requests
    expect(UAgent.os_breakdown).to eq({"Windows Vista"=>2,
                                       "Linux"=>3,
                                       "Mac OS"=>1})
  end

  it "groups by user agent" do
    make_some_u_agents_and_payload_requests
    expect(UAgent.group_by_u_agent).to eq({1=>2, 2=>3, 3=>1})
  end
end
