class PayloadRequest < ActiveRecord::Base
  belongs_to :url
  belongs_to :source
  belongs_to :request_type
  belongs_to :u_agent
  belongs_to :screen_resolution
  belongs_to :client
  belongs_to :ip_address

  validates :url_id, presence: true
  validates :requested_at, presence: true
  validates :responded_in, presence: true
  validates :source_id, presence: true
  validates :request_type_id, presence: true
  validates :u_agent_id, presence: true
  validates :screen_resolution_id, presence: true
  validates :ip_address_id, presence: true
  validates :client_id, presence: true

  def self.average_response_time
    average(:responded_in).to_i
  end

  def self.max_response_time
    maximum(:responded_in).to_i
  end

  def self.min_response_time
    minimum(:responded_in).to_i
  end
end
