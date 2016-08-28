require './spec/spec_helper'
require './app/controllers/data_parser'

describe "Client Dashboard", :type => :feature do

  after :each do
    DatabaseCleaner.clean
  end

  it "displays a registered client its client dashboard" do

    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    Dummy.request_type_1
    Dummy.request_type_2
    Dummy.request_type_3
    Dummy.screen_resolution_1
    Dummy.screen_resolution_2
    Dummy.screen_resolution_3
    Dummy.source_1
    Dummy.source_2
    Dummy.source_3
    Dummy.u_agent_1
    Dummy.u_agent_2
    Dummy.u_agent_3
    Dummy.url_1
    Dummy.url_2
    Dummy.url_3

    visit '/sources/jumpstartlab'
    expect(page).to have_content "jumpstartlab"
  end

  it "displays an error if an unregistered client visits dashboard" do

    client = Dummy.client_1
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    Dummy.request_type_1
    Dummy.request_type_2
    Dummy.request_type_3
    Dummy.screen_resolution_1
    Dummy.screen_resolution_2
    Dummy.screen_resolution_3
    Dummy.source_1
    Dummy.source_2
    Dummy.source_3
    Dummy.u_agent_1
    Dummy.u_agent_2
    Dummy.u_agent_3
    Dummy.url_1
    Dummy.url_2
    Dummy.url_3

    visit '/sources/unregistered_client'
    expect(page).to have_content "Client not found"
  end

  it "displays an error if a registered client visits dashboard with no payloads" do

    client = Dummy.client_1
    payload_less_client = Dummy.client_2
    Dummy.payload_request_1
    Dummy.payload_request_2
    Dummy.payload_request_3
    Dummy.request_type_1
    Dummy.request_type_2
    Dummy.request_type_3
    Dummy.screen_resolution_1
    Dummy.screen_resolution_2
    Dummy.screen_resolution_3
    Dummy.source_1
    Dummy.source_2
    Dummy.source_3
    Dummy.u_agent_1
    Dummy.u_agent_2
    Dummy.u_agent_3
    Dummy.url_1
    Dummy.url_2
    Dummy.url_3

    visit '/sources/turing'
    expect(page).to have_content "No payload requests found"
  end
end
