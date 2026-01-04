require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'rail_road'

@rr = RailRoad.new
@rr.seed
@rr.menu