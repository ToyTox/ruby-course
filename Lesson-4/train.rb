class Train
  attr_accessor :speed
  attr_reader :number
  attr_reader :type
  attr_accessor :wagons
  attr_accessor :route
  attr_accessor :current_station_index

  def initialize(number, type)
    @speed = 0
    @number = number
    @type = type
    @wagons = []
    @current_station_index = 0
  end

  def speed_up
    self.speed += 10
  end

  def speed_down
    self.speed -= 10 if speed > 0
  end

  def set_route(route)
    self.route = route
  end

  def next_station
    self.route.stations[self.current_station_index + 1]
  end

  def previous_station
    self.route.stations[self.current_station_index - 1] if self.current_station_index > 0
  end

  def current_station
    self.route.stations[self.current_station_index]
  end

  def move_forward
    self.current_station_index += 1 if next_station
  end

  def move_backward
    self.current_station_index -= 1 if previous_station
  end

  def stations
    [previous_station, current_station, next_station]
  end

  def create_wagons(count, type)
    if count.is_a?(Integer) && count > 0
      i = 0
      while i < count
        self.wagons << Wagon.new(type)
        i += 1
      end
    end
  end

  def add_wagon
    self.wagons << Wagon.new(self.type)
  end

  def remove_wagon
    if self.wagons.size > 0
      self.wagons.pop
    else
      puts "У состава больне нет вагонов"
      puts
    end
  end
end