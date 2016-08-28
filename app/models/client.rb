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

  # def average_response_time
  #   payload_requests.average_response_time
  # end
  #
  # def verbs
  #   payload_requests.request_types.list_verbs
  # end
end
