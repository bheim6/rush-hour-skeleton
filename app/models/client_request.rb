class ClientRequest
  attr_reader :identifier,
              :root_url

  def initialize(params)
    @identifier = params["identifier"]
    @root_url = params["rootUrl"]

  end

  def invalid_identifier?
    identifier.nil? || identifier == ""
  end

  def invalid_root_url?
    root_url.nil? || root_url == ""
  end

  def invalid_params?
    invalid_identifier? || invalid_root_url?
  end

  def client_exists?
    Client.find_by("identifier" => identifier).class == Client
  end

  def status
    return 400 if invalid_params?
    return 403 if client_exists?
    return 200 unless(invalid_params? || client_exists?)
  end

  def message
    return "Parameters must include identifier and rootUrl." if status == 400
    return "Client already exists" if status == 403
    return JSON.generate({"identifier" => identifier}) if status == 200
  end

end
