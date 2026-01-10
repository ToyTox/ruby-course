class Station
  attr_accessor :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    trains << train
  end

  def remove_train(train_index)
    trains.delete_at(train_index)
  end

  def trains_by_types(type)
    trains.filter{ |train| train.type == type }.count
  end

  def go_train(train)
    trains.delete(train)
  end
end