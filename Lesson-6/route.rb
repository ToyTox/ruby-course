class Route
  include InstanceCounter
  include Validator

  class RouteError < StandardError; end

  attr_reader :start_station
  attr_reader :end_station
  attr_accessor :stations
  
  def initialize(start_station, end_station)
    validate_stations!(start_station, end_station)

    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
    register_instance
    valid?
  end

  def add_station(station)
    raise RouteError "Станция не может быть nil" unless station
    raise RouteError "Станция уже в маршруте" if stations.include?(station)

    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  private
  
  def validate_stations!(start_station, end_station)
    raise RouteError "Начальная станция не может быть nil" unless start_station
    raise RouteError "Конечная станция не может быть nil" unless end_station
    raise RouteError "Начальная и конечная станция должны отличаться" if start_station == end_station
  end
end