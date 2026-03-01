class Station
  include InstanceCounter
  include Validator

  MIN_NAME_LENGTH = 2

  attr_reader :trains
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
    valid?
  end

  def add_train(train)
    trains << train
  end

  def all_trains
    if block_given?
      trains.each { |train| yield(train) }
    else
      trains
    end
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_by_types(type)
    trains.select { |train| train.type == type }.count
  end

  def validate!
    raise "Имя станции не может быть nil" if name.nil?
    raise "Имя станции не может быть пустым" if name.strip.empty?
    raise "Имя не может быть короче 2 симыолов" if name.strip.length < MIN_NAME_LENGTH
  end
end