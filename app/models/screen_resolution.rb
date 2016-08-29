class ScreenResolution < ActiveRecord::Base
  has_many :payload_requests
  validates :height, presence: true
  validates :height, uniqueness: {scope: :width}
  validates :width, presence: true
  validates :width, uniqueness: {scope: :height}

  def self.display_resolutions
    pluck(:width, :height)
  end
end
