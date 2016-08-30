require './spec/spec_helper'
require './app/models/payload_request_request'

RSpec.describe PayloadRequestRequest, type: :model do

  after :each do
    DatabaseCleaner.clean
  end

  def create_client
    Client.create("identifier" => "jumpstartlab",
      "root_url" => "www.jumpstartlab.com")
  end

  def invalid_payload(key)
    payload = JSON.parse(valid_payload)
    payload[key] = ""
    return JSON.generate(payload)
  end

  def valid_payload
    '{"url":"http://jumpstartlab.com/blog",
     "requestedAt":"2013-02-16 21:38:28 -0700",
     "respondedIn":37,
     "referredBy":"http://jumpstartlab.com",
     "requestType":"GET",
     "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
     "resolutionWidth":"1920",
     "resolutionHeight":"1280",
     "ip":"63.29.38.211"}'
  end

  it "has expected payload parameters" do
    pr = PayloadRequestRequest.new({"payload" => valid_payload,
                                    "identifier"=> "jumpstartlab"})
    expected_payload_params = [ "url", "requestedAt", "respondedIn",
                                "referredBy", "requestType", "userAgent",
                                "resolutionWidth", "resolutionHeight", "ip" ]

    expect(pr.payload_params).to eq(expected_payload_params)
  end

  it "checks for invalid parameters resulting from missing url" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("url"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing requested at" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("requestedAt"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing responded in" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("respondedIn"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing referred by" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("referredBy"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing user agent" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("userAgent"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing resolution width" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("resolutionWidth"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing resolution height" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("resolutionHeight"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing referred by" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("referredBy"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing ip address" do
    pr = PayloadRequestRequest.new({"payload" => invalid_payload("ip"),
                                    "identifier"=> "jumpstartlab"})

    expect(pr.invalid_payload?).to be(true)
    expect(pr.status).to eq(400)
    expect(pr.message).to eq(message_400)
  end

  it "checks for invalid parameters resulting from missing payload" do
    pr_1 = PayloadRequestRequest.new({"payload" => "",
                                      "identifier"=> "jumpstartlab"})
    pr_2 = PayloadRequestRequest.new({"identifier"=> "jumpstartlab"})
    pr_3 = PayloadRequestRequest.new({"payload" => valid_payload,
                                      "identifier"=> "jumpstartlab"})

    expect(pr_1.bad_params?).to be(true)
    expect(pr_1.status).to eq(400)
    expect(pr_1.message).to eq(message_400)

    expect(pr_2.bad_params?).to be(true)
    expect(pr_2.status).to eq(400)
    expect(pr_2.message).to eq(message_400)

    expect(pr_3.bad_params?).to be(false)
  end

  it "checks for invalid parameters resulting from missing identifier" do
    pr_1 = PayloadRequestRequest.new({"payload" => valid_payload,
                                      "identifier"=> ""})
    pr_2 = PayloadRequestRequest.new({"payload" => valid_payload})
    pr_3 = PayloadRequestRequest.new({"payload" => valid_payload,
                                      "identifier"=> "jumpstartlab"})

    expect(pr_1.bad_params?).to be(true)
    expect(pr_1.status).to eq(400)
    expect(pr_1.message).to eq(message_400)

    expect(pr_2.bad_params?).to be(true)
    expect(pr_2.status).to eq(400)
    expect(pr_2.message).to eq(message_400)

    expect(pr_3.bad_params?).to be(false)
  end

  it "returns status 403 if payload request already exists" do
    PayloadRequest.create({ "url_id"=>1,
                            "requested_at"=>"2013-02-16 21:38:28 -0700",
                            "responded_in"=>37,
                            "source_id"=>1,
                            "request_type_id"=>1,
                            "u_agent_id"=>1,
                            "screen_resolution_id"=>1,
                            "ip_address_id"=>1,
                            "client_id"=>1})
    create_client

    pr_1 = PayloadRequestRequest.new({"payload" => valid_payload, "identifier"=> "jumpstartlab"})

    expect(pr_1.payload_request_exists?).to eq(true)
    expect(pr_1.status).to eq(403)
    expect(pr_1.message).to eq("Payload request already exists")
  end

  it "returns a status 403 if the client application does not exist" do
    PayloadRequest.create({ "url_id"=>1,
                            "requested_at"=>"2013-02-16 21:38:28 -0700",
                            "responded_in"=>37,
                            "source_id"=>1,
                            "request_type_id"=>1,
                            "u_agent_id"=>1,
                            "screen_resolution_id"=>1,
                            "ip_address_id"=>1,
                            "client_id"=>1})
    pr_1 = PayloadRequestRequest.new({"payload" => valid_payload, "identifier"=> "jumpstartlab"})

    expect(pr_1.status).to eq(403)
    expect(pr_1.message).to eq("Application does not exist")
  end

  it "returns status 200 and identifier message when it creates a new payload request" do
    create_client
    count = PayloadRequest.count
    pr_1 = PayloadRequestRequest.new({"payload" => valid_payload, "identifier"=> "jumpstartlab"})
    # binding.pry
    expect(pr_1.status).to eq(200)
    expect(PayloadRequest.all.count).to eq(count + 1)
  end


  def message_400
    "Parameters must include url, requestedAt, respondedIn, referredBy, requestType, userAgent, resolutionWidth, resolutionHeight and ip."
  end
end
# it "returns erb template based on status" do
#   client_2 = Dummy.client_2
#   identifier = client_2.identifier
#
#   cr_1 = ClientRequest.new(valid_params)
#   cr_2 = ClientRequest.new({"identifier" => "turing", "rootUrl" => "www.turing.io"})
#   cr_3 = ClientRequest.new({})
#
#   expect(cr_1.erb).to eq(:dashboard)
#   expect(cr_2.erb).to eq(:error)
#   expect(cr_3.erb).to eq(:error)
# end
