class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def all
    puts @stations
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