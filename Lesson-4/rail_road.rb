class RailRoad
  attr_accessor :stations

  def initialize
    @stations = []
  end

  def menu
    puts "Список команд. Введите цифру согласно желаемому действию"
    puts "1 - Создать станцию"
    puts "2 - Создать поезд"
    puts "3 - Создать маршрут"
    puts "4 - Назначить маршрут поезду"
    puts "5 - Добавить вагон к поезду"
    puts "6 - Отправить поезд на станцию"
    puts "7 - Посмотреть список поездов на станции"
    puts "0 - Выход"

    answer = gets.chomp.to_i

    case answer
    when 1
      add_station
      puts ""
    when 2
      add_train
      puts ""
    when 3
      puts "Создание маршрута..."
      # управлять станциями в нем (добавлять, удалять)
      # case 
    when 4
      puts "Назначить маршрут поезду..."
    when 5
      puts "Добавить вагон к поезду..."
    when 6
      puts "Отправить поезд на станцию..."
      # Показать станция, которая впереди, которая сзади
      # двигать только на одну стацию, не дальше
    when 7
      puts "Посмотреть список поездов на станции..."
    when 0
      puts "Досвидания"
    when 99
      puts trains_list
    else
      puts "Такой команды не существует"
    end
  end

  def add_station
    puts "Задайте название станции"
    station_name = gets.chomp
    station = Station.new(station_name)
    puts "Станция #{station_name} создана"
    self.stations << station
  end
  
  def add_train
    puts "На какой станции формируется состав"
    stations_list
    station_index = gets.chomp.to_i

    puts "Задайте номер поезда"
    train_number = gets.chomp.to_i

    puts "Выберите тип поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
    train_type = gets.chomp.to_i
    
    puts "Задайте число вагонов у поезда поезда"
    wagon_count = gets.chomp.to_i
    
    train = train_type == 1 ? PassengerTrain.new(train_number, train_type, wagon_count) : CargoTrain.new(train_number, train_type, wagon_count)
    puts "Поезд номер #{train_number} создан"
    self.trains << train
  end
  
  # Helpers

  def stations_list
    puts "Список станций:"
    self.stations.each_with_index do |station, idx|
      puts "#{idx + 1} - #{station.name}"
    end
  end

  def find_station(index)
    @stations[index]
  end
  
  def trains_list
    puts "Выберите станцию:"
    stations_list
    station_index = gets.chomp.to_i - 1

    station = find_station(station_index)

    puts "Список поездов на станции #{station.name}:"
    station.trains.each_with_index do |train, idx|
      puts "#{idx + 1} - Поезд номер #{train.number}, типа #{train.type}, в составе #{train.wagon_count} вагон(а/ов)"
    end
  end

  def seed
    stations_name = ["Moscow" , "Saint-Petersburg", "Rybinsk"]
    trains = [[1231, 2, 34], [123, 1, 13], [2234, 2, 52]]

    stations_name.each do |station, idx|
      self.stations << Station.new(station)
    end

    self.stations.each_with_index do |station, idx|
      station.add_train(trains[idx][1] == 1 ? PassengerTrain.new(trains[idx][0], trains[idx][1], trains[idx][2]) : CargoTrain.new(trains[idx][0], trains[idx][1], trains[idx][2]))
    end
  end
end


