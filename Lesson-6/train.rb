class Train
  include CompanyName
  include InstanceCounter
  include Validator

  attr_accessor :speed
  attr_reader :number
  attr_reader :type
  attr_accessor :wagons
  attr_accessor :route
  attr_accessor :current_station_index

  REGEXP_TRAIN_NUMBER = /^[a-zA-Z0-9]{3}-?[a-zA-Z0-9]{2}$/i

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number)
    @speed = 0
    @number = number
    @wagons = []
    @current_station_index = 0
    @@trains[number] = self
    register_instance
    validate!
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
    return unless count.is_a?(Integer) && count.positive?

    count.times do
      wagon = type == :passenger ? PassengerWagon.new : CargoWagon.new
      wagons << wagon
    end
  end

  def add_wagon(wagon)
    wagons << wagon
  end

  def remove_wagon
    wagons.pop if wagons.size > 0
  end

  def wagon_type_matches?(wagon)
    (self.type == :cargo && wagon.type == :cargo) ||
    (self.type == :passenger && wagon.type == :passenger)
  end

  protected

  def validate!
    raise "Номер не может быть nil или пустым" if number.nil? || number.zero?
    raise "Не корректный номер поезда" if number !~ REGEXP_TRAIN_NUMBER
  end
end