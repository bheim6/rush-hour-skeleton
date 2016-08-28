require './spec/spec_helper'
require './app/controllers/data_parser'

describe "Client URL Dashboard", :type => :feature do

  before :each do
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
  end

  after :each do
    DatabaseCleaner.clean
  end

  it "displays a registered client its url dashboard" do
    visit '/sources/jumpstartlab/urls/blog'
    expect(page).to have_content "jumpstartlab"
  end

  it "displays an error if a client visits an unregistered url dashboard" do
    visit '/sources/jumpstartlab/urls/index'
    expect(page).to have_content "This is not a registered URL"
  end
end
