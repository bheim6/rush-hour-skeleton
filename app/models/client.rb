class Client < ActiveRecord::Base
  has_many :payload_requests
  has_many :request_types, through: :payload_requests
  has_many :urls, through: :payload_requests
  has_many :u_agents, through: :payload_requests
  has_many :sources, through: :payload_requests
  has_many :screen_resolutions, through: :payload_requests
  has_many :ip_addresses, through: :payload_requests
  validates :identifier, presence: true
  validates :root_url, presence: true
  validates :identifier, uniqueness: true
  validates :root_url, uniqueness: true

  def average_response_time
    payload_requests.average_response_time
  end

  def max_response_time
    payload_requests.max_response_time
  end

  def min_response_time
    payload_requests.min_response_time
  end

  def most_frequent_request_type
    request_types.most_frequent_request_type.verb
  end

  def list_verbs
    request_types.list_verbs.uniq
  end

  def browser_breakdown
    u_agents.browser_breakdown
  end

  def os_breakdown
    u_agents.os_breakdown
  end

  def display_resolutions
    screen_resolutions.display_resolutions
  end

  def url_max_response_time(url)
    url.max_response_time
  end

  def url_min_response_time(url)
    url.min_response_time
  end

  def list_response_times(url)
    url.response_times.uniq
  end

  def avg_response_time(url)
    url.avg_response_time
  end

  def list_verbs_for(url)
    url.verbs
  end

  def most_popular_sources_for(url)
    url.top_3_sources
  end

  def most_popular_u_agents_for(url)
    url.top_3_u_agents
  end



end
