class UAgent < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients
  validates :browser, presence: true
  validates :browser, uniqueness: {scope: :operating_system}
  validates :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}

  def self.u_agent_breakdown
    # breakdown("browser")
    # joins(:payload_requests).group(:browser).count(:browser)
    # u_agent_id_counts = payload_requests.order("u_agent_id").group("u_agent_id").count
    joins(:payload_requests).group(:u_agents).count.to_a.map do |u_agent_string_count|
      id = u_agent_string_count[0].split(",")[0].sub("(", "")
      [UAgent.find_by(id: id) ,u_agent_string_count[1]]
    end.to_h

    # binding.pry
    # u_agent_id_counts = PayloadRequest.group("u_agent_id")
    # group_by_u_agent.to_a.reduce({}) do |result, grouping|
    #   u_agent = UAgent.find_by(:id => grouping[0]).browser
    #   result = incrament_browser_count(result, u_agent, grouping[1])
    # end
  end

  def self.os_breakdown
    breakdown("operating_system")
  end

  def self.breakdown(type)
    group_by_u_agent.to_a.reduce({}) do |result, grouping|
      u_agent = UAgent.find_by(:id => grouping[0]).send(type)
      result = incrament_browser_count(result, u_agent, grouping[1])
    end
  end

  def self.group_by_u_agent
    PayloadRequest.group('u_agent_id').count
  end

  private
  def self.incrament_browser_count(result, browser, count)
    result.has_key?(browser) ? result[browser] += count : result[browser] = count
    result
  end

end
