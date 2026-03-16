# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validator

  MIN_NAME_LENGTH = 2

  attr_reader :trains, :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    valid?
    # validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def all_trains(&block)
    if block_given?
      trains.each(&block)
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
    raise ValidatorError, 'Имя станции не может быть nil' if name.nil?
    raise ValidatorError, 'Имя станции не может быть пустым' if name.strip.empty?
    raise ValidatorError, "Имя не может быть короче #{MIN_NAME_LENGTH} символов" if name.strip.length < MIN_NAME_LENGTH
  end
end
