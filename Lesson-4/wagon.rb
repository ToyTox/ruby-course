class Wagon
  attr_accessor :wagon_count
  attr_accessor :type

  def initialize(wagon_count, type)
    @wagon_count = wagon_count
    @type = type
  end

  def add_wagon
    self.wagon_count += 1
  end

  def remove_wagon
    if self.wagon_count > 0
      self.wagon_count -= 1
    else
      puts "У состава больне нет вагонов"
    end
  end
end