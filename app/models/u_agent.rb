class UAgent < ActiveRecord::Base
  has_many :payload_requests
  has_many :clients
  validates :browser, presence: true
  validates :browser, uniqueness: {scope: :operating_system}
  validates :operating_system, presence: true
  validates :operating_system, uniqueness: {scope: :browser}

end
