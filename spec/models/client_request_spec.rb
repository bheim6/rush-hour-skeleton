require './spec/spec_helper'
require './app/models/client_request'

RSpec.describe ClientRequest, type: :model do
  after :each do
    DatabaseCleaner.clean
  end
  
  def valid_params
    {"identifier" => "jumpstartlab", "rootUrl" => "www.jumpstartlab.com"}
  end

  it "is initialized with params" do
    params = {"identifier" => "jumpstartlab", "rootUrl" => "www.jumpstartlab.com"}
    cr = ClientRequest.new(params)

    expect(cr).to be_instance_of(ClientRequest)
  end

  it "checks for invalid identifier resulting from missing identifier" do
    invalid_params_1 = {"identifier" => "", "rootUrl" => "www.jumpstartlab.com"}
    invalid_params_2 = {"rootUrl" => "www.jumpstartlab.com"}

    cr_1 = ClientRequest.new(invalid_params_1)
    cr_2 = ClientRequest.new(invalid_params_2)
    cr_3 = ClientRequest.new(valid_params)

    expect(cr_1.invalid_identifier?).to be(true)
    expect(cr_2.invalid_identifier?).to be(true)
    expect(cr_3.invalid_identifier?).to be(false)
  end

  it "checks for invalid params resulting from missing root url" do
    invalid_params_1 = {"identifier" => "jumpstartlab" }
    invalid_params_2 = {"identifier" => "jumpstartlab", "rootUrl" => ""}

    cr_1 = ClientRequest.new(invalid_params_1)
    cr_2 = ClientRequest.new(invalid_params_2)
    cr_3 = ClientRequest.new(valid_params)

    expect(cr_1.invalid_root_url?).to be(true)
    expect(cr_2.invalid_root_url?).to be(true)
    expect(cr_3.invalid_root_url?).to be(false)
  end

  it "checks for valid params resulting from missing root url or identifier" do
    invalid_params_1 = {"identifier" => "", "rootUrl" => "www.jumpstartlab.com"}
    invalid_params_2 = {"rootUrl" => "www.jumpstartlab.com"}
    invalid_params_3 = {"identifier" => "jumpstartlab" }
    invalid_params_4 = {"identifier" => "jumpstartlab", "rootUrl" => ""}

    cr_1 = ClientRequest.new(invalid_params_1)
    cr_2 = ClientRequest.new(invalid_params_2)
    cr_3 = ClientRequest.new(invalid_params_3)
    cr_4 = ClientRequest.new(invalid_params_4)
    cr_5 = ClientRequest.new(valid_params)

    expect(cr_1.invalid_params?).to be(true)
    expect(cr_2.invalid_params?).to be(true)
    expect(cr_3.invalid_params?).to be(true)
    expect(cr_4.invalid_params?).to be(true)
    expect(cr_5.invalid_params?).to be(false)
  end

  it "has status 400 if there is invalid params" do
    invalid_params_1 = {"rootUrl" => "www.jumpstartlab.com"}
    invalid_params_2 = {"identifier" => "jumpstartlab" }

    cr_1 = ClientRequest.new(invalid_params_1)
    cr_2 = ClientRequest.new(invalid_params_2)
    cr_3 = ClientRequest.new(valid_params)

    expect(cr_1.status).to be(400)
    expect(cr_2.status).to be(400)
    expect(cr_3.status).not_to be(400)
  end

  it "checks if client already exists" do
    client_2 = Dummy.client_2
    identifier = client_2.identifier

    cr_1 = ClientRequest.new(valid_params)
    cr_2 = ClientRequest.new({"identifier" => "turing", "rootUrl" => "www.turing.io"})

    expect(cr_1.client_exists?).to be(false)
    expect(cr_2.client_exists?).to be(true)
  end

  it "has status 403 if the client already exists" do
    client_2 = Dummy.client_2
    identifier = client_2.identifier

    cr_1 = ClientRequest.new(valid_params)
    cr_2 = ClientRequest.new({"identifier" => "turing", "rootUrl" => "www.turing.io"})

    expect(cr_1.status).not_to be(400)
    expect(cr_1.status).not_to be(403)
    expect(cr_2.status).to be(403)
  end

  it "has status 200 if it is a new client" do
    cr_1 = ClientRequest.new(valid_params)

    expect(cr_1.status).to be(200)
  end

  it "has a 400 message" do
    invalid_params_1 = {"rootUrl" => "www.jumpstartlab.com"}
    invalid_params_2 = {"identifier" => "jumpstartlab" }

    cr_1 = ClientRequest.new(invalid_params_1)
    cr_2 = ClientRequest.new(valid_params)

    expect(cr_1.message).to eq("Parameters must include identifier and rootUrl.")
    expect(cr_2.message).not_to eq("Parameters must include identifier and rootUrl.")
  end

  it "has a 403 message" do
    client_2 = Dummy.client_2
    identifier = client_2.identifier

    cr_1 = ClientRequest.new(valid_params)
    cr_2 = ClientRequest.new({"identifier" => "turing", "rootUrl" => "www.turing.io"})

    expect(cr_1.message).not_to eq("Parameters must include identifier and rootUrl.")
    expect(cr_1.message).not_to eq("Client already exists")
    expect(cr_2.message).to eq("Client already exists")
  end

  it "has a 200 message" do
    cr_1 = ClientRequest.new(valid_params)

    expect(cr_1.message).to eq("{\"identifier\":\"jumpstartlab\"}")
  end

end
