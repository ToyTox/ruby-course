class Route
  attr_reader :start_station
  attr_reader :end_station
  attr_accessor :stations

  def initialize(start_station, end_station)
    @start_station = start_station
    @end_station = end_station
    @stations = [start_station, end_station]
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    if station == start_station
      puts "Нельзя удалять начальную станцию"
    elsif station == end_station
      puts "Нельзя удалять конечную станцию"
    else
      stations.delete(station)
    end
  end
end