# test/train_test.rb
require 'minitest/autorun'
require_relative '../train'
require_relative '../passenger_train'
require_relative '../cargo_train'
require_relative '../passenger_wagon'
require_relative '../cargo_wagon'
require_relative '../route'
require_relative '../station'

class TrainTest < Minitest::Test
  def setup
    @passenger_train = PassengerTrain.new(123, :passenger)
    @cargo_train = CargoTrain. new(456, :cargo)
  end
  
  def test_passenger_train_type
    assert_equal :passenger, @passenger_train.type
  end
  
  def test_cargo_train_type
    assert_equal :cargo, @cargo_train.type
  end
  
  def test_add_matching_wagon
    wagon = PassengerWagon.new
    result = @passenger_train.add_wagon(wagon)
    assert result, "Должен успешно добавить подходящий тип вагона"
    assert_equal 1, @passenger_train.wagons.size
  end
  
  def test_reject_wrong_wagon_type
    wagon = CargoWagon.new
    result = @passenger_train.add_wagon(wagon)
    refute result, "Должен отклонить неправильный тип вагона"
    assert_equal 0, @passenger_train.wagons.size
  end
  
  def test_train_movement
    station1 = Station.new("Москва")
    station2 = Station. new("СПБ")
    route = Route.new(station1, station2)
    
    @passenger_train.set_route(route)
    assert_equal station1, @passenger_train.current_station
    
    @passenger_train.move_forward
    assert_equal station2, @passenger_train.current_station
  end
end