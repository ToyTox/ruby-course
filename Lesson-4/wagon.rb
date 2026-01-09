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
    self.wagon_count -= 1
  end
end