class Train
  attr_accessor :speed
  attr_reader :number
  attr_reader :type
  attr_accessor :wagons
  attr_accessor :route
  attr_accessor :current_station_index

  def initialize(number)
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
    return nil unless route
    route.stations[current_station_index + 1]
  end

  def previous_station
    return nil unless route
    return nil if current_station_index <= 0
    route.stations[current_station_index - 1]
  end

  def current_station
    return nil unless route
    route.stations[current_station_index]
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
        wagons << Wagon.new(type)
        i += 1
      end
    end
  end

  def add_wagon(wagon)
    if wagon_type_matches?(wagon)
      wagons << wagon
      true
    else
      puts "Нельзя прицепить #{wagon.type} вагон к #{train.type} поезду"
      false
    end
  end

  def remove_wagon
    if wagons.size > 0
      wagons.pop
    else
      puts "У состава больше нет вагонов"
      puts
    end
  end

  private

  def wagon_type_matches?(wagon)
    (self.type == :cargo && wagon.type == :cargo) ||
    (self.type == :passenger && wagon.type == :passenger)
  end
end