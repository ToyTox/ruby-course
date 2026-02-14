class Station
  include InstanceCounter
  include Validator

  attr_accessor :trains
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def add_train(train)
    trains << train
  end

  def remove_train(train)
    trains.delete(train)
  end

  def trains_by_types(type)
    trains.select { |train| train.type == type }.count
  end
end