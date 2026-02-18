require_relative 'company_name'
require_relative 'instance_counter'
require_relative 'validator'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'wagon'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'rail_road'

@railway_system = RailRoad.new
@railway_system.seed
@railway_system.menu