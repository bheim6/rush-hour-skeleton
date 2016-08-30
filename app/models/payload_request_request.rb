class PayloadRequestRequest

  attr_reader :identifier,
              :payload,
              :params,
              :payload_request,
              :exists,
              :status

  def initialize(params)
    @params = params
    @identifier = params["identifier"]
    @payload = bad_params? ? nil : JSON.parse(params["payload"])
    @payload_request = forbidden? ? nil : DataParser.new(params).parse_payload
    @exits = payload_request.nil? ? nil : payload_request_exists?
    @status = set_status
    if status == 200
      create
    end
  end

  def invalid_payload?
     payload_params.any? do |payload_param|
       payload[payload_param].nil? || payload[payload_param] == ""
     end
  end

  def payload_params
    ["url", "requestedAt", "respondedIn", "referredBy", "requestType",
     "userAgent", "resolutionWidth", "resolutionHeight", "ip"]
  end

  def bad_params?
    missing_payload? || missing_identifier?
  end

  def registered_identifier?
    Client.find_by("identifier" => identifier).class == Client
  end

  def payload_request_exists?
    pr = PayloadRequest.where(url_id: payload_request["url_id"],
                              requested_at: payload_request["requested_at"].getutc,
                              responded_in: payload_request["responded_in"],
                              source_id: payload_request["source_id"],
                              request_type_id: payload_request["request_type_id"],
                              u_agent_id: payload_request["u_agent_id"],
                              screen_resolution_id: payload_request["screen_resolution_id"],
                              ip_address_id: payload_request["ip_address_id"],
                              client_id: payload_request["client_id"])
    !pr.empty?
  end


  def message
    return message_400 if forbidden?
    return "Payload request already exists" if payload_request_exists?
    return "Application does not exist" if !registered_identifier?
    return "Success" if status == 200
  end

  def set_status
    return 400 if forbidden?
    return 403 if payload_request_exists? || !registered_identifier?
    return 200
  end

  private

  def missing_payload?
    params["payload"].nil? || params["payload"] == ""
  end

  def missing_identifier?
    params["identifier"].nil? || params["identifier"] == ""
  end

  def forbidden?
    bad_params? || invalid_payload?
  end

  def message_400
    "Parameters must include #{payload_params[0..7].join(', ')} and #{payload_params[8]}."
  end

  def create
    if ok_to_create?
      PayloadRequest.create(payload_request)
    end
  end

  def ok_to_create?
    !forbidden? && new_request_from_registered_client?
  end


  def new_request_from_registered_client?
    !payload_request_exists? && registered_identifier?
  end

  # def erb
  #   return :error if status == 400 || status == 403
  #   return :dashboard if status == 200
  # end

end
