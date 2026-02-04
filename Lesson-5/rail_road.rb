class RailRoad
  attr_accessor :stations
  attr_accessor :routes

  # Тип поездов
  PASSENGER_TYPE = :passenger
  CARGO_TYPE = :cargo

  # Направление
  DIRECTION_FORWARD = 1
  DIRECTION_BACKWARD = 2

  # Опции меню
  MENU_CREATE_STATION = 1
  MENU_CREATE_TRAIN = 2
  MENU_EXIT = 0


  def initialize
    @stations = []
    @routes = []
  end

  def menu
    loop do
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

      user_choice = gets.chomp.to_i

      case user_choice
      when 1
        add_station
        puts
      when 2
        add_train
        puts
      when 3
        add_route
        puts
        
        puts "Перейти в управление маршрутами?"
        puts "1 - Да"
        puts "2 - Нет"

        answer = gets.chomp.to_i

        if answer == 1
          route_control
        elsif answer == 2
          puts "Переход в главное меню"
        else
          puts "Такого варианта не существует"
        end
      when 4
        route_control
        puts
      when 5
        route_index = select_from_list(routes, 'маршрут', :routes_list)
        station = routes[route_index].start_station
        puts "Первая станция в маршруте #{station.name}"

        stations.each_with_index do |s, idx|
          if s.name == station.name
            trains_list_on_station(idx)
          end
        end

        puts "Выберите поезд, которому хотите назначить маршрут"
        train_index = gets.chomp.to_i - 1

        station.trains[train_index].set_route(routes[route_index])
        puts "Поезду N #{station.trains[train_index].number} присвоен маршрут #{routes[route_index].start_station.name} - #{routes[route_index].end_station.name}"
      when 6
        wagon_control('add')
      when 7
        wagon_control('remove')
      when 8
        station_index = select_from_list(stations, 'станцию', :stations_list)

        puts "Выберите поезд, который хотите отправить"
        trains_list_on_station(station_index)
        train_index = gets.chomp.to_i - 1

        puts "Выберите куда отправляем поезд"
        puts "1 - На следующую станцию"
        puts "2 - На предыдущую станцию"
        direction = gets.chomp.to_i

        train = stations[station_index].trains[train_index]
        if direction == DIRECTION_FORWARD && train.next_station
          train.current_station.remove_train(train)
          train.next_station.add_train(train)
          train.move_forward
        elsif direction == DIRECTION_BACKWARD && train.previous_station
          train.current_station.remove_train(train)
          train.previous_station.add_train(train)
          train.move_backward
        elsif direction == DIRECTION_FORWARD
          puts "Поезд уже на конечной станции маршрута"
        elsif direction == DIRECTION_BACKWARD
          puts "Поезд уже на первой станции маршрута"
        end

        puts "Поезд N#{train.number} переместился на станцию #{train.current_station.name}"
      when 9
        puts "Список поездов на станции"
        trains_list_on_station
      when 0
        puts "Досвидания"
        break
      else
        puts "Такой команды не существует"
      end
    end
  end

  def seed
    stations_name = ["Moscow" , "Saint-Petersburg", "Rybinsk", "Tomsk"]
    trains = [[1231, :cargo, 3], [123, :passenger, 1], [2234, :cargo, 5], []]

    stations_name.each do |station, idx|
      stations << Station.new(station)
    end

    stations.each_with_index do |station, idx|
      unless trains[idx].size == 0
        if trains[idx][1] == PASSENGER_TYPE
          train = PassengerTrain.new(trains[idx][0])
          train.create_wagons(trains[idx][2], trains[idx][1])
        else
          train = CargoTrain.new(trains[idx][0])
          train.create_wagons(trains[idx][2], trains[idx][1])
        end
        station.add_train(train)
      end
    end

    route = Route.new(stations[0], stations[1])
    route.add_station(stations[3])
    routes << route
    # stations[0].trains[0].set_route(route)
  end

  # Методы ниже помечены как private, потому что: 
  # - Они являются вспомогательными для публичного метода menu()
  # - Используются только внутри класса RailRoad
  # - Не должны вызываться напрямую пользователем для поддержания инкапсуляции
  private

  def get_valid_index(collection, prompt)
    loop do
      puts prompt
      puts "Введите номер от 1 до #{collection.size} (или 0 при отмене)"
      index = gets.chomp.to_i
  
      return nil if index == 0
  
      index -= 1
      if index >= 0 && index < collection.size
        return index
      else
        puts "Такого действия не существует"
      end
    end
  end

  def add_station
    puts "Задайте название станции"
    station_name = gets.chomp
    station = Station.new(station_name)
    puts "Станция #{station_name} создана"
    stations << station
  end
  
  def add_train
    station_index = get_valid_index(stations, "Выберите станцию")
    return unless station_index

    puts "Задайте номер поезда"
    train_number = gets.chomp.to_i

    puts "Выберите тип поезда:"
    puts "1 - Пассажирский"
    puts "2 - Грузовой"
    train_type_index = gets.chomp.to_i
    train_type = train_type_index == 1 ? PASSENGER_TYPE : CARGO_TYPE
    
    puts "Задайте число вагонов у поезда поезда"
    wagon_count = gets.chomp.to_i

    if train_type == PASSENGER_TYPE
      train = PassengerTrain.new(train_number)
      train.create_wagons(wagon_count, train_type)
    else
      train = CargoTrain.new(train_number)
      train.create_wagons(wagon_count, train_type)
    end
    
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
    routes << route
  end

  def route_control
    route_index = select_from_list(routes, 'маршрут', :routes_list)

    if route_index < 0 || route_index >= routes.size
      puts "Такого маршрута не существует"
    else
      loop do
        puts "Выберите действие с маршрутом"
        puts "1 - Добавить станцию в маршрут"
        puts "2 - Удалить станцию из маршрута"
        puts "0 - Маршрут готов"
        route_control = gets.chomp.to_i
        break if route_control == 0
  
        station_index = select_from_list(stations, 'станцию', :stations_list)

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
  end

  def wagon_control(action)
    station_index = select_from_list(stations, 'станцию на которой стоит поезд', :stations_list)

    puts "Выберите поезд к которому хотите прицепить вагон"
    trains_list_on_station(station_index)
    train_index = gets.chomp.to_i - 1
    train = stations[station_index].trains[train_index]

    if action == 'add'
      wagon = train.type == :passenger ? PassengerWagon.new : CargoWagon.new
      train.add_wagon(wagon)
    else
      train.remove_wagon
    end
    puts "В поезде N#{train.number} теперь #{train.wagons.size} вагон(а/ов)"
  end
  
  # Helpers

  def select_from_list(collection, item_name, display_method)
    return nil if collection.empty?

    puts "Выберите #{item_name} из списка:"
    send(display_method) if display_method

    get_valid_index(collection, "Введите номер #{item_name}:")
  end

  def stations_list
    puts "Список станций:"
    stations.each_with_index do |station, idx|
      puts "#{idx + 1} - #{station.name}"
    end
  end

  def find_station(index)
    @stations[index]
  end
  
  def trains_list_on_station(station_index = nil)
    unless station_index
      station_index = select_from_list(stations, 'станцию', :stations_list)
    end

    station = find_station(station_index)

    puts "Список поездов на станции #{station.name}:"
    station.trains.each_with_index do |train, idx|
      puts "#{idx + 1} - Поезд номер #{train.number}, типа #{train.type}, в составе #{train.wagons.size} вагон(а/ов)"
    end
  end

  def routes_list
    puts "Список маршрутов:"
    routes.each_with_index do |route, idx|
      puts "#{idx + 1} - #{route.start_station.name} - #{route.end_station.name}"
    end
  end
end


