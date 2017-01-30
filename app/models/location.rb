class Location < ActiveRecord::Base
  validates :name, :level, presence: true

  has_and_belongs_to_many :users

  enum level: {
    country: 0,
    state: 10,
    region: 20,
    city: 30,
    postcode: 40
  }

  scope :regions, -> { where(level: Location.levels[:region]) }

end
