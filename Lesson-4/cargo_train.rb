class CargoTrain < Train
  def initialize
    super(:cargo)
  end

  def type
    :cargo
  end
end