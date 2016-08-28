module Dummy
  def self.client_1
    Client.create("identifier" => "jumpstartlab", "root_url" => "www.jumpstartlab.com")
  end

  def self.client_2
    Client.create("identifier" => "turing", "root_url" => "www.turing.io")
  end

  def self.client_3
    Client.create("identifier" => "google", "root_url" => "www.google.com")
  end

  def self.ip_address_1
    IpAddress.create("address" => "63.29.38.211")
  end

  def self.ip_address_2
    IpAddress.create("address" => "63.29.30.01")
  end

  def self.ip_address_3
    IpAddress.create("address" => "55.29.28.211")
  end

  def self.payload_request_1
    payload_request_template(1, 1, 1, 1, 1, 1, 1, 10)
  end

  def self.payload_request_2
    payload_request_template(2, 2, 2, 2, 2, 2, 1, 20)
  end

  def self.payload_request_3
    payload_request_template(3, 3, 3, 3, 3, 3, 1, 30)
  end

  def self.payload_request_4
    payload_request_template(4, 1, 1, 1, 1, 1, 2, 10)
  end

  def self.payload_request_5
    payload_request_template(5, 2, 2, 2, 2, 2, 2, 20)
  end

  def self.payload_request_6
    payload_request_template(6, 3, 3, 3, 3, 3, 2, 30)
  end

  def self.payload_request_7
    payload_request_template(7, 1, 1, 1, 1, 1, 3)
  end

  def self.payload_request_8
    payload_request_template(8, 2, 2, 2, 2, 2, 3)
  end

  def self.payload_request_9
    payload_request_template(9, 3, 3, 3, 3, 3, 3)
  end

  def self.payload_request_custom(url_id, source_id, request_type_id, u_agent_id, screen_resolution_id, ip_address_id, client_id, response_time=rand(40))
    payload_request_template(url_id, source_id, request_type_id, u_agent_id, screen_resolution_id, ip_address_id, client_id, response_time)
  end

  def self.request_type_1
    RequestType.create("verb" => "GET")
  end

  def self.request_type_2
    RequestType.create("verb" => "POST")
  end

  def self.request_type_3
    RequestType.create("verb" => "DELETE")
  end

  def self.screen_resolution_1
    ScreenResolution.create("height" =>"1280", "width" => "1920")
  end

  def self.screen_resolution_2
    ScreenResolution.create("height" =>"480", "width" => "640")
  end

  def self.screen_resolution_3
    ScreenResolution.create("height" =>"600", "width" => "800")
  end

  def self.source_1
    Source.create("address" =>"www.jumpstartlab.com")
  end

  def self.source_2
    Source.create("address" =>"www.turing.io")
  end

  def self.source_3
    Source.create("address" =>"www.google.com")
  end

  def self.u_agent_1
    UAgent.create("operating_system" =>"Windows Vista", "browser" =>"Chrome")
  end

  def self.u_agent_2
    UAgent.create("operating_system" =>"MAC OSX", "browser" =>"Chrome")
  end

  def self.u_agent_3
    UAgent.create("operating_system" =>"Linux", "browser" =>"Firefox")
  end

  def self.url_1
    Url.create("address" =>"www.jumpstartlab/blog/1")
  end

  def self.url_2
    Url.create("address" => "www.jumpstartlab/blog/2")
  end

  def self.url_3
    Url.create("address" => "www.jumpstartlab/blog/3")
  end

  def self.url_4
    Url.create("address" =>"www.turing/blog/1")
  end

  def self.url_5
    Url.create("address" => "www.turing/blog/2")
  end

  def self.url_6
    Url.create("address" => "www.turing/blog/3")
  end

  def self.url_7
    Url.create("address" =>"www.google/blog/1")
  end

  def self.url_8
    Url.create("address" => "www.google/blog/2")
  end

  def self.url_9
    Url.create("address" => "www.google/blog/3")
  end




  private

  def self.payload_request_template(url_id, source_id, request_type_id, u_agent_id, screen_resolution_id, ip_address_id, client_id, response_time=rand(40))
    PayloadRequest.create(
      "url_id"=>url_id,
      "requested_at"=>Time.new,
      "source_id"=>source_id,
      "request_type_id"=>request_type_id,
      "u_agent_id"=>u_agent_id,
      "screen_resolution_id"=>screen_resolution_id,
      "ip_address_id"=>ip_address_id,
      "client_id"=>client_id,
      "responded_in"=>response_time)
  end
end
