class Station
  attr_accessor :trains
  attr_reader :name

  @@stations = []

  def self.all
    @@stations.each { |station| puts station.name }
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
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

  def go_train(train)
    trains.delete(train)
  end
end