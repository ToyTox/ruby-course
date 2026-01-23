class CargoWagon < Wagon
  def initialize
    super(:cargo)
  end

  def type
    :cargo
  end
end