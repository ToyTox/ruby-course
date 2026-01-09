class RailRoad
  attr_accessor :stations
  attr_accessor :routes

  def initialize
    @stations = []
    @routes = []
  end

  def menu
    puts "Список команд. Введите цифру согласно желаемому действию"
    puts "1 - Создать станцию"
    puts "2 - Создать поезд"
    puts "3 - Создать маршрут"
    puts "4 - Управлять маршрутом"
    puts "5 - Назначить маршрут поезду"
    puts "6 - Прицепить вагон к поезду"
    puts "7 - Отцепить вагон от поезда"
    puts "8 - Отправить поезд на станцию"
    puts "9 - Посмотреть список поездов на станции"
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
      add_route
      puts ""
      # управлять станциями в нем (добавлять, удалять)
      puts "Перейти в управление маршрутами?"
      puts "1 - Да"
      puts "2 - Нет"
      answer = gets.chomp.to_i

      route_control if answer == 1
    when 4
      route_control
      puts ""
    when 5
      puts "Выберите маршрут"
      routes_list
      route_index = gets.chomp.to_i - 1
      station = routes[route_index].start_station
      puts "Первая станция в маршрте #{routes[route_index].start_station.name}"

      trains_list_on_station(route_index)
      puts "Выберите поезд, которому хотите назначить маршрут"
      train_index = gets.chomp.to_i - 1

      station.trains[train_index].set_route(routes[route_index])
      puts "Поезду N #{station.trains[train_index].number} присвоен маршрут #{routes[route_index].start_station.name} - #{routes[route_index].end_station.name}"
    when 6
      wagon_control('add')
    when 7
      wagon_control('remove')
    when 8
      puts "Отправить поезд на станцию..."
      # Показать станция, которая впереди, которая сзади
      # двигать только на одну стацию, не дальше
    when 9
      puts "Посмотреть список поездов на станции..."
    when 0
      puts "Досвидания"
    when 99
      puts trains_list_on_station
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
    station_index = gets.chomp.to_i - 1

    puts "Задайте номер поезда"
    train_number = gets.chomp.to_i

    puts "Выберите тип поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
    train_type_index = gets.chomp.to_i
    train_type = train_type_index == 1 ? 'passenger' : 'cargo'
    
    puts "Задайте число вагонов у поезда поезда"
    wagon_count = gets.chomp.to_i
    
    train = train_type_index == 1 ? PassengerTrain.new(train_number, train_type, wagon_count) : CargoTrain.new(train_number, train_type, wagon_count)
    puts "Поезд номер #{train_number} создан"
    stations[station_index].add_train(train)
  end

  def add_route
    puts "Выберите начальную станцию"
    stations_list
    start_station_index = gets.chomp.to_i - 1

    puts "Выберите конечную станцию"
    stations_list
    end_station_index = gets.chomp.to_i - 1

    route = Route.new(stations[start_station_index], stations[end_station_index])
    self.routes << route
    @current_station_index = 0
  end

  def route_control
    puts "Выберите маршрут"
    routes_list
    route_index = gets.chomp.to_i - 1

    while true
      puts "Выберите действие с маршрутом"
      puts "1 - Добавить станцию в маршрут"
      puts "2 - Удалить станцию из маршрута"
      puts "0 - Маршрут готов"
      route_control = gets.chomp.to_i
      break if route_control == 0

      puts "Выберите станцию"
        stations_list
        station_index = gets.chomp.to_i - 1
      case route_control
      when 1
        routes[route_index].add_station(stations[station_index])
        puts routes[route_index].inspect
      when 2
        routes[route_index].remove_station(stations[station_index])
        puts routes[route_index].inspect
      else
        "Такой команды не существует"
      end
    end
    
  end

  def wagon_control(action)
    puts "Выберите станцию на которой стоит поезд"
    stations_list
    station_index = gets.chomp.to_i - 1

    puts "Выберите поезд к которому хотите прицепить вагон"
    trains_list_on_station(station_index)
    train_index = gets.chomp.to_i - 1
    train = self.stations[station_index].trains[train_index]

    action == 'add' ? train.wagons.add_wagon : train.wagons.remove_wagon
    puts "В поезде N#{train.number} теперь #{train.wagons.wagon_count} вагон(а/ов)"
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
  
  def trains_list_on_station(station_index = nil)
    unless station_index
      puts "Выберите станцию:"
      stations_list
      station_index = gets.chomp.to_i - 1
    end

    station = find_station(station_index)

    puts "Список поездов на станции #{station.name}:"
    station.trains.each_with_index do |train, idx|
      puts "#{idx + 1} - Поезд номер #{train.number}, типа #{train.type}, в составе #{train.wagons.wagon_count} вагон(а/ов)"
    end
  end

  def routes_list
    puts "Список маргрутов:"
    self.routes.each_with_index do |route, idx|
      puts "#{idx + 1} - #{route.start_station.name} - #{route.end_station.name}"
    end
  end

  def seed
    stations_name = ["Moscow" , "Saint-Petersburg", "Rybinsk"]
    trains = [[1231, 'cargo', 34], [123, 'passenger', 13], [2234, 'cargo', 52]]

    stations_name.each do |station, idx|
      self.stations << Station.new(station)
    end

    self.stations.each_with_index do |station, idx|
      station.add_train(trains[idx][1] == 1 ? PassengerTrain.new(trains[idx][0], trains[idx][1], trains[idx][2]) : CargoTrain.new(trains[idx][0], trains[idx][1], trains[idx][2]))
    end

    route = Route.new(stations[0], stations[1])
    self.routes << route
    @current_station_index = 0
  end
end


