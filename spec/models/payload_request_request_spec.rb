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
